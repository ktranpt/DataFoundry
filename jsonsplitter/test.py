# for a array value of a key
unflat_json = {"559893529209": {"improvement_surcharge": 0.3, "congestion_surcharge": 2.5}, "993405808080": {"improvement_surcharge": 0.3, "congestion_surcharge": 0.0}, "267031741304": {"improvement_surcharge": 0.3, "congestion_surcharge": 0.0}, "355132875433": {"improvement_surcharge": 0.3, "congestion_surcharge": 0.0}
			}

# Function for flattening
# json


def flatten_json(y):
	out = {}

	def flatten(x, name=''):

		# If the Nested key-value
		# pair is of dict type
		if type(x) is dict:

			for a in x:
				flatten(x[a], name + a + '_')

		# If the Nested key-value
		# pair is of list type
		elif type(x) is list:

			i = 0

			for a in x:
				flatten(a, name + str(i) + '_')
				i += 1
		else:
			out[name[:-1]] = x

	flatten(y)
	return out


# Driver code
print(flatten_json(unflat_json))
print("Hello")