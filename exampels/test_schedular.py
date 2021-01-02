import sys
sys.path.append('..')

from backend.data import DataManager
from backend.logic import Scheduler, Item
from datetime import date

# Sample orders
order_one = {"client_id": 1001, "order_id": 34, "date": date.today(), "out_date": date(2021,2,1), 
            "items_id_prio_quant": [(104771, 2, 10), (780302, 1, 2), (710702, 3, 10)]}


order_two = {"client_id": 1001, "order_id": 12, "date": date.today(), "out_date": date(2021,1,1), 
            "items_id_prio_quant": [(727299, 2, 10), (750585, 1, 2), (30320, 3, 10), (730051, 1, 2), (117471, 3, 10)]}

transport = [{"id":23, "unit_type":"truck"}, 
                {"id":213, "unit_type":"container"}]                
if __name__ == "__main__":
    # create data manager instance and connect to DB
    man = DataManager("packlog",dbname="packlog", username="packlog")
    man.connect()
    
    # initialize a schedular
    scheduler = Scheduler(man)

    ### Item Pool ###
    # add single item to pool
    pool_dic = scheduler.add_order_to_pool(man.getArticle(100245), 10, 1000, "AB123", date.today(), date(2021,1,1), 1)

    # given an order add manually multiple items to pool  
    for item_id, prio, quant in order_one["items_id_prio_quant"]:
        scheduler.add_order_to_pool(man.getArticle(item_id), quant, order_one["client_id"], order_one["order_id"], 
                                    order_one["date"], order_one["out_date"], prio)

    # given an order add to pool  
    scheduler.add_full_order_to_pool(order_two)

    # print the current pool
    print(scheduler.pool)

    # sort and output pool 
    scheduler.order_pool()
    print(scheduler.pool_ordered)
    print(scheduler.pool_ordered[1001])
    ### Transport Units ###
    # Add single transporter to the transport units
    scheduler.add_trans({"id":99, "unit_type":"truck"})
    # Add multiple transporter to the transport units
    scheduler.add_trans_list(transport)

    print(scheduler.transport_units)

    
    