import requests
import json
import random

BASE_URL = "https://packlogsolutions.osc-fr1.scalingo.io/"

# test data

with open("./backend/examples/sample_orders/second_order_order_two.json", 'r') as f:
    items = json.load(f)
for item in items:
    item["prio"] = random.randint(1,3)
item_dict = {"client_id": 1, "order_id": 2, "date": (1,1,20), "out_date": (1,1,20), "transport_unit": "truck", "items_id_prio_quant": items}

# make POST request to estimator URL
response = requests.post(BASE_URL + "estimator", json=item_dict)
print(response.text)
response = requests.post(BASE_URL + "packer", json=item_dict)
print(response.text)