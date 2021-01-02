import sys
sys.path.append('..')

from backend.data import DataManager
from backend.logic import Scheduler, Item, TransportUnit, Packer
from backend.logic.planning_util import free_trans_cap, client_items_cap, full_items_cap
from datetime import date

# Sample orders
order_one = {"client_id": 1001, "order_id": 34, "date": date.today(), "out_date": date(2021,2,1), 
            "items_id_prio_quant": [(104771, 1, 25), (780302, 1, 1000), (710702, 3, 100)]}

order_two = {"client_id": 1001, "order_id": 12, "date": date.today(), "out_date": date(2021,1,1), 
            "items_id_prio_quant": [(727299, 2, 300), (750585, 1, 1000), (30320, 3, 10), (730051, 1, 1000), (117471, 2, 100)]}

order_three = {"client_id": 1002, "order_id": 12, "date": date.today(), "out_date": date(2021,1,1), 
            "items_id_prio_quant": [(20620, 1, 10), (114615, 3, 2), (31639, 3, 10), (730051, 3, 2), (117471, 3, 10)]}

transport = [{"id":23, "unit_type":"truck"}, 
                {"id":213, "unit_type":"small_truck"},
                {"id":43, "unit_type":"container"}]

if __name__ == "__main__":
    # create data manager instance and connect to DB
    man = DataManager("packlog",dbname="packlog", username="packlog")
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
    print("Number of \"%s\" needed for client's %d ordered items with prio %d: %f \n" % ("truck", 1001, 1, scheduler.trans_unit_estimate("truck", 1001, 1)))

    # add multiple transport units
    scheduler.add_trans_list(transport)
    # initialize packer
    packer = Packer(scheduler.transport_units, scheduler.pool_ordered)

    matched_cap = packer.fit_capacities(1001)
    print(matched_cap)
    
    # capacity of all items of the client 1001, with prio 2 and order id 12
    print("Capacity of items of client {} with given priority {} and order ID {}: {}. \n".format(1001, 1, 12, client_items_cap(packer.pool_ordered, 1001, prio=1, order_id=12)))

    # free capacity of the transport units
    free_trans_cap(packer.transport_units, report=True)
    print("\n")

    print("Packed vs unpacked capacity with decending priority: {}\n".format(packer.load_client_items(1001)))

    # free capacity of the transport units
    print("Dictonary of items loaded in transport unit {}: {}\n".format(23,packer.transport_units[23].loaded_item_pool))

    print(free_trans_cap(packer.transport_units, report=True))



