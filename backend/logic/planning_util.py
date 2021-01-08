from . import Item, TransportUnit
    
def free_trans_cap(transport_units, report=False):
    """ Calculates the free capacity in the transport units.

        Args:
            tranport_units: A dictionary of transport units.
                            Example: {id<1>: transunit_instance, ..., id<n>:transunit_instance}
    """
    capacity = 0
    for unit in transport_units:
        capacity += transport_units[unit].cap_free
        if report:
            print("Transport unit {0} has {1} square meter free space left, {2} square meter are allready filled.".format(unit, transport_units[unit].cap_free, transport_units[unit].cap_used))
    return capacity


def client_items_cap(pool, client_id, prio=None, order_id=None):
    """ Calculates the capcity of the items in a pool. The calculation can be restricted to items with a given priority, order_id
        or priority and order_id.
    """ 
    capacity = 0.0
    # capacity of all items ordered by the client
    if prio is None and order_id is None:
        for item_id in pool[client_id]:
            capacity += pool[client_id][item_id].cap
    # capacity of the client's items given a prio
    elif prio is not None and order_id is None:
        for item_id in pool[client_id]:
            capacity += pool[client_id][item_id].cap if pool[client_id][item_id].prio == prio else 0
    # capacity of the client's items given a order id
    elif prio is None and order_id is not None:
        for item_id in pool[client_id]:
            capacity += pool[client_id][item_id].cap if pool[client_id][item_id].order_id == order_id else 0
    # capacity of the client's items given a order id and a prio
    else:
        for item_id in pool[client_id]:
            capacity += pool[client_id][item_id].cap if pool[client_id][item_id].order_id == order_id and pool[client_id][item_id].prio == prio else 0
    return capacity

def full_items_cap(pool, prio=None):
    # calculates the capacity of all items in the pool. Can be restricted by the prio
    capacity = 0
    for client_id in pool:
        capacity += client_items_cap(pool, client_id, prio=prio)
    return capacity