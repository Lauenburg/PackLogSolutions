import requests
import json

BASE_URL = "http://127.0.0.1:5000/"

# test data

with open("./backend/examples/sample_orders/first_orders_order_one.json", 'r') as f:
    items = json.load(f)
item_dict = {"client_id": 1, "order_id": 2, "date": (1,1,20), "out_date": (1,1,20), "transport_unit": "truck", "items_id_prio_quant": items}

# make POST request to estimator URL
response = requests.post(BASE_URL + "estimator", json=item_dict)
print(response.text)