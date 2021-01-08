import sys
sys.path.append('..')

from backend.data import DataManager
from backend.logic import Scheduler, Item, TransportUnit, Packer
from backend.logic.planning_util import free_trans_cap, client_items_cap, full_items_cap
from backend.data.data_util import read_from_xl, write_dic_to_json
from datetime import date
import random
import argparse

parser = argparse.ArgumentParser(description="test schedular")
parser.add_argument("-n", "--dbname", help="database name", type=str)
parser.add_argument("-u", "--username", help="username name", type=str)
parser.add_argument("-fa", "--file-article", help="article file name", type=str)
parser.add_argument("-ft", "--file-transobj", help="tansobj file name", type=str)
parser.add_argument("-p", "--password", help="user password", type=str, required=True)
args = parser.parse_args()

# Sample orders
order_one = {"client_id": 1001, "order_id": 34, "date": date.today(), "out_date": date(2021,2,1), 
            "items_id_prio_quant": [(104771, 1, 25), (780302, 1, 1000), (710702, 3, 100)]}

order_two = {"client_id": 1001, "order_id": 12, "date": date.today(), "out_date": date(2021,1,1), 
            "items_id_prio_quant": [(727299, 2, 300), (750585, 1, 1000), (30320, 3, 10), (730051, 1, 1000), (117471, 2, 100)]}

order_three = {"client_id": 1002, "order_id": 12, "date": date.today(), "out_date": date(2021,1,1), 
            "items_id_prio_quant": [(20620, 1, 10), (114615, 3, 2), (31639, 3, 10), (730051, 3, 2), (117471, 3, 10)]}

# Sample transport units
transport = [{"id":23, "unit_type":"truck"}, 
                {"id":213, "unit_type":"small_truck"},
                {"id":43, "unit_type":"container"}]

transport1 = [{"id":23, "unit_type":"truck"}]

if __name__ == "__main__":
    # create data manager instance and connect to DB
    man = DataManager(args.password, args.dbname, args.username, args.file_article, args.file_transobj)
    man.connect()
    
    # initialize a schedular
    scheduler = Scheduler(man)

    # add multiple items to pool given an order
    scheduler.add_full_order_to_pool(order_one)
    scheduler.add_full_order_to_pool(order_two)
    scheduler.add_full_order_to_pool(order_three)

    # create ordered version of the pool
    scheduler.order_pool()

    # estimate number of trucks needed for the order item of prio 1 of client 1001
    trans_estimate = scheduler.trans_unit_estimate("truck", 1001, 1)
    print("Number of \"%s\" needed for client's %d ordered items with prio %d: %f \n" % ("truck", 1001, 1, trans_estimate))

    # add multiple transport units
    scheduler.add_trans_list(transport)
    # initialize packer
    packer = Packer(scheduler.transport_units, scheduler.pool_ordered)

    # estimate the volume of the items (depending on prio) that fit in to the transport unit
    fitted_cap = packer.fit_capacities(1001)
    print("Item volume based on prio that fit the in to the transport units: {} \n".format(fitted_cap))
    
    # capacity of all items of the client 1001, with prio 2 and order id 12
    print("Capacity of items of client {} with given priority {} and order ID {}: {}. \n".format(1001, 1, 12, client_items_cap(packer.pool_ordered, 1001, prio=1, order_id=12)))

    # free capacity of the transport units
    free_trans_cap(packer.transport_units, report=True)
    print("\n")

    print("Packed vs unpacked capacity with decending priority: {}\n".format(packer.load_client_items(1001)))

    # free capacity of the transport units
    print("Dictonary of items loaded in transport unit {}: {}\n".format(23,packer.transport_units[23].loaded_item_pool))

    print(free_trans_cap(packer.transport_units, report=True))

    # Test with order loaded by data_util.py
    json_dic = read_from_xl('./backend/examples/sample_orders/first_orders.xlsx', 
                        "order_one", ["quantity", "id", "name", "weight", "volume"])
    # Create order dic from parsed order
    order_four = {"client_id": 2001, "order_id": 2, "date": date.today(), "out_date": date(2021,1,25), "items_id_prio_quant": []}
    for item in json_dic:
        order_four["items_id_prio_quant"].append((int(item["id"]), random.randint(1,3), int(item["quantity"])))

    # add new order to pool
    scheduler.add_full_order_to_pool(order_four)
    # reorder pool
    scheduler.order_pool()
    print(scheduler.pool_ordered[2001])
    # new packer
    packer2 = Packer(scheduler.transport_units, scheduler.pool_ordered)

    # estimate the volume of the items (depending on prio) that fit in to the transport unit
    fitted_cap = packer2.fit_capacities(2001)
    print("Item volume based on prio that fit the in to the transport units: {} \n".format(fitted_cap))

