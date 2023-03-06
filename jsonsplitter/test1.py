# Python program to read
# json file


import json

# Opening JSON file
f = open('C:\Users\ekpan\OneDrive\Documents\GitHub\jsonsplitter\surcharge_data.json',)

# returns JSON object as
# a dictionary
data = json.load(f)

# Iterating through the json
# list
for i in data['improvement_surcharge']:
	print(data)

# Closing file
f.close()
