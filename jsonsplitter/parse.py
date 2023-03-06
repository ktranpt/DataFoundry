
# importing json library
import json
 
with open('surcharge_data.json') as f:
  data = json.load(f)
 
# printing data after loading the json file
print(data)