import requests
import json

BASE_URL = "http://127.0.0.1:5000/"

# test data
item_1 = {"order_id":110011, "date": "26/01/2020", "quantity": 10, "prio": 0}
item_id_1 = 104771
item_2 = {"order_id":110011, "date": "26/01/2020", "quantity": 20, "prio": 1}
item_id_2 = 105386

item_dict = {item_id_1: item_1, item_id_2: item_2}

# make POST request to estimator URL
response = requests.post(BASE_URL + "estimator", json={"data": item_dict})
print(response.text)