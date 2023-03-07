--PUT file to S3 bucket: datafoundrykqt

s3://datafoundrykqt/trips.csv

--IAM: Create Redshift role 
arn:aws:iam::201993417919:role/myredshiftrole

-- Create tables in Redshift

--Create trips table
CREATE TABLE public.trips (
    vendorid character varying(256) ENCODE lzo,
    tpep_pickup_datetime timestamp without time zone ENCODE az64,
    tpep_dropoff_datetime timestamp without time zone ENCODE az64,
    passenger_count character varying(256) ENCODE lzo,
    trip_distance numeric(18, 0) ENCODE az64,
    ratecodeid character varying(256) ENCODE lzo,
    store_and_fwd_flag character(1) ENCODE lzo,
    pulocationid character varying(256) ENCODE lzo,
    dolocationid character varying(256) ENCODE lzo,
    payment_type character varying(256) ENCODE lzo,
    fare_amount numeric(18, 0) ENCODE az64,
    extra numeric(18, 0) ENCODE az64,
    mta_tax numeric(18, 0) ENCODE az64,
    tip_amount numeric(18, 0) ENCODE az64,
    tolls_amount numeric(18, 0) ENCODE az64,
    tripid character varying(256) ENCODE lzo
) DISTSTYLE AUTO;

--Create surcharge table
create table surcharge (
    tripid varchar,
    improvement_surcharge numeric(18,2), 
    congestion_surcharge numeric(18,2)
    );


--Load data from S3 into Redshift table--

COPY dev.public.trips FROM 's3://datafoundrykqt/trips.csv' IAM_ROLE 'arn:aws:iam::201993417919:role/myredshiftrole' FORMAT AS CSV DELIMITER ',' QUOTE '"' IGNOREHEADER 1 REGION AS 'ap-southeast-2'

COPY dev.public.surcharge FROM 's3://datafoundrykqt/surcharge.csv' IAM_ROLE 'arn:aws:iam::201993417919:role/myredshiftrole' FORMAT AS CSV DELIMITER ',' QUOTE '"' IGNOREHEADER 1 REGION AS 'ap-southeast-2'

--Clean data 

UPDATE PUBLIC.trips
SET vendorid = replace(vendorid, CHAR(.0), '')
WHERE charindex(CHAR)

UPDATE trips
SET vendorid = (
		CASE vendorid
			WHEN '1.0'
				THEN '1'
			WHEN '2.0'
				THEN '2'
			ELSE 0
			END
		);

--Assume empty passenger count equal to 1--
UPDATE trips
SET passenger_count = 1
WHERE passenger_count = '';

--Assume empty Rate Code ID equal to 1=Standard rate--
UPDATE trips
SET ratecodeid = 1
WHERE ratecodeid = '';

UPDATE trips
SET vendorid = cast(vendorid AS INTEGER);

UPDATE trips
SET passenger_count = cast(passenger_count AS INTEGER);

UPDATE trips
SET ratecodeid = cast(ratecodeid AS INTEGER);

UPDATE trips
SET payment_type = cast(payment_type AS INTEGER);

--Connect Dataset from RedShift Serverless to Tableau manually
--Join trips and surcharge table on Tableau by TripID
