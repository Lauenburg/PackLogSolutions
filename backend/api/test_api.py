import requests

BASE_URL = "http://127.0.0.1:5000/"

item_1 = {"quantity": 10, "prio": 0}
item_id_1 = 104771
item_2 = {"quantity": 20, "prio": 1}
item_id_2 = 105386
order_id = 1
customer_id = 110011

item_dict = {item_id_1: item_1, item_id_2: item_2}
order_dict = {order_id: item_dict, order_id+1: item_dict}
print(order_dict)

response = requests.get(BASE_URL + "estimator", {"data": {customer_id: order_dict}})
# response = requests.get(BASE_URL + "estimator", {"likes": 123})
print(response.json())