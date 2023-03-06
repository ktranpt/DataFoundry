# -*- coding: utf-8 -*-
"""
Spyder Editor

Khanh Tran
05/03/2023
"""

import json
import pandas as pd

raw_js = r'C:\Users\ekpan\OneDrive\Documents\Ty folder\Data foundry\raw_data\surcharge_data.json'
# new_js = r'C:\Users\ekpan\OneDrive\Documents\Ty folder\Data foundry\raw_data\surcharge1.json'
new_csv = r'C:\Users\ekpan\OneDrive\Documents\Ty folder\Data foundry\raw_data\surcharge1.csv' 


with open(raw_js) as json_file:
    data = json.load(json_file)

# n_dict = {}

# for key, value in data.items():
#     value['ID'] = key
#     n_dict[k] = value


# with open(new_js, 'w') as json_file:
#     json.dump(n_dict, json_file)

n_ls = []
for key, value in data.items():
    imp_sur = value['improvement_surcharge']
    con_sur = value['congestion_surcharge']
    n_ls.append([int(key), imp_sur, con_sur])
    
df = pd.DataFrame(n_ls, columns = ['TripID', 'improvement_surcharge', 'congestion_surcharge'])
df.set_index('TripID', inplace = True)

df.to_csv(new_csv)

