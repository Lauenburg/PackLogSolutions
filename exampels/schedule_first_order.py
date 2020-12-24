import sys
sys.path.append('..')

from data import DataManager
from backend.logic import *
from datetime import date

order_one = {"client_id": 1001, "order_id": 34, "date": date.today(), "out_date": date(2021,2,1), 
            "items_id_prio_quant": [(104771, 2, 10), (780302, 1, 2), (710702, 3, 10)]}


order_two = {"client_id": 1001, "order_id": 12, "date": date.today(), "out_date": date(2021,1,1), 
            "items_id_prio_quant": [(727299, 2, 10), (750585, 1, 2), (30320, 3, 10), (730051, 1, 2), (117471, 3, 10)]}

if __name__ == "__main__":
    # create data manager instance and connect to DB
    man = DataManager("packlog",dbname="packlog", username="packlog")
    man.connect()
    
    # retrive single item from database
    item_query = man.getArticle(104771)
    
    # retrive a list of items from the DB
    item_query_list = man.getArticles([104771, 780302, 710702])

    # create Item instance from item query
    item = Item.from_item_query(item_query)

    # initialize a schedular
    scheduler = Scheduler(man)

    # add single item to pool
    pool_dic = scheduler.add_order_to_pool(item_query, 10, 1111, "AB123", date.today(), date(2021,1,1), 1)

    # add multiple items to pool
    # create a list of items

    for item_id, prio, quant in order_one["items_id_prio_quant"]:
        scheduler.add_order_to_pool(man.getArticle(item_id), quant, order_one["client_id"], order_one["order_id"], 
                                    order_one["date"], order_one["out_date"], prio)

    for item_id, prio, quant in order_two["items_id_prio_quant"]:
        scheduler.add_order_to_pool(man.getArticle(item_id), quant, order_two["client_id"], order_two["order_id"], 
                                    order_two["date"], order_two["out_date"], prio)    

    #print(scheduler.pool)      
    print(scheduler.order_client_pool(order_one["client_id"]))                  