from data import DataManager
from backend.logic import *
from datetime import date

item_dict = {104771: (10, 1), 105386: (20,2)}
print("item_dict: ", item_dict)

#order_dict = {123: (date.today(), item_dict), 234: (date(2020, 1, 26), item_dict)}
#print("order_dict: ", order_dict)
a = {}
a["b"] = 1
print(a)
man = DataManager("packlog",dbname="packlog", username="packlog")
man.connect()

scheduler = Scheduler(man)
order_list = scheduler.schedulePoolByDate(123456, order_dict)
print("order_list: ", order_list)
print("items (order 1): ", order_list[0].items)
