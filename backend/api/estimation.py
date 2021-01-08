from ..logic import Scheduler, Packer

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
    return {1: trans_estimate_1, 2: trans_estimate_2, 3: trans_estimate_3}