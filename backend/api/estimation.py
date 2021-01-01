from ..logic import Scheduler, Packer

def rough_estimation(client_id, order_dict, transport_units, data_manager):

    scheduler = Scheduler(data_manager)
    scheduler.add_full_order_to_pool(order_dict)
    scheduler.order_pool()
    ordered_pool = scheduler._ordered_item_list(client_id)
    
    packer = Packer(transport_units, ordered_pool)
    return packer.load_client_items(client_id)