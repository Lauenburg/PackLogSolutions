from ..logic import Scheduler, Packer
import math

def rough_estimation(order_dict, data_manager):

    client_id = order_dict["client_id"]
    transport_unit = order_dict["transport_unit"]

    scheduler = Scheduler(data_manager)
    scheduler.add_full_order_to_pool(order_dict)
    scheduler.order_pool()
    
    trans_estimate_1 = scheduler.trans_unit_estimate(transport_unit, client_id, 1)
    trans_estimate_2 = scheduler.trans_unit_estimate(transport_unit, client_id, 2)
    trans_estimate_3 = scheduler.trans_unit_estimate(transport_unit, client_id, 3)
    
    # packer = Packer(scheduler.transport_units, scheduler.pool_ordered)
    return {'estimate': {   1: [trans_estimate_1, 0], \
                            2: [0, trans_estimate_2], \
                            3: [0, trans_estimate_3]
                        }
            }


def fill_last_transport_unit(order_dict, data_manager):

    client_id = order_dict["client_id"]
    transport_unit = order_dict["transport_unit"]

    ##### TODO: #####

    scheduler = Scheduler(data_manager)
    scheduler.add_full_order_to_pool(order_dict)
    scheduler.order_pool()
    n_trans_units = math.floor(scheduler.trans_unit_estimate(transport_unit, client_id, 1)) + 1
    transport_units = [{"id": 23, "unit_type": "truck"} for i in range(n_trans_units)]
    scheduler.add_trans_list(transport_units)

    packer = Packer(scheduler.transport_units, scheduler.pool_ordered)
    packed_vs_unpacked = packer.load_client_items(client_id)

    packed_item_key_list = packer.pool_ordered[client_id].keys() ^ packer.pool_ordered_unpacked[client_id].keys() 
    print(packed_item_key_list)
    n_items_last = list()
    for item_key in packed_item_key_list:
        if packer.pool_ordered[client_id][item_key].prio != 1:
            n_items_last.append(item_key)
    #################


    return {'estimate': {   1: [packed_vs_unpacked[0][0], packed_vs_unpacked[0][1]], \
                            2: [packed_vs_unpacked[1][0], packed_vs_unpacked[1][1]], \
                            3: [packed_vs_unpacked[2][0], packed_vs_unpacked[2][1]]
                        },
            'n_items_last': n_items_last
            }