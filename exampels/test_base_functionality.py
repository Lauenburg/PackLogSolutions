import sys
sys.path.append('..')

from backend.data import DataManager
from backend.logic import Item
from datetime import date

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

    # initialize Item instance from item query
    item = Item.from_item_query(item_query)

    # initialize full Item instance from item query and order
    item_id, prio, quant = order_two["items_id_prio_quant"][0]
    item_full = Item.from_item_query(item_query, quant, order_two["client_id"], order_two["order_id"], 
                                    order_two["date"], order_two["out_date"], prio) 

    a = [False,False,False,False]
    print(a.index(True))