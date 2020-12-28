from . import Item, TransportUnit
import copy

class Packer:
    
    def __init__(self, transport_units, pool_ordered):
        self.transport_units = transport_units
        assert bool(pool_ordered) # ensure that pool_ordered is not an empty dic -> call scheduler.order_pool()
        self.pool_ordered = pool_ordered
        # create a copy  of the pool of ordered items to keep track of what has been packed so far
        self.pool_ordered_unpacked = copy.deepcopy(pool_ordered)
        # keep track which trucks are full
        self.units_full = [False] * len(transport_units)
        self.all_units_full = False
        self.pool_empty = False

    def load_client_items(self, client_id, prio=None):
        """ Packs all items in the item pool corresponding to the client id in to the available transport units.
            The function stops packing when either all items with priority < prio got packed, all items in the customer item pool 
            got packed or all transport units are full.  

            Returns:
                A tuple of tuples of format: ((pack_cap_prio_1,unpack_cap_prio_1),(pack_cap_prio_2,unpack_cap_prio_2),(pack_cap_prio_3,unpack_cap_prio_3))
        """
        
        # Calculate the still available free capacity of the transport units and the capacity of the unpacked items.
        free_cap = self.free_trans_cap()
        item_cap = self.client_items_cap(self.pool_ordered_unpacked, client_id, prio)
        print("Currently free transportation capacity: ", free_cap)
        print("capacity of the items scheduled for packing: ", item_cap)

        # select the first transport unit in the list that is not full yet
        try:
            current_trans_unit = self.transport_units[list(self.transport_units.keys())[self.units_full.index(False)]]
        except ValueError:
            self.all_units_full = True
            print("Their is not not enough space left in the transport units")

        # runs till all items (of the client) in the list are packed in to the transport units or all units are full
        while not bool(self.all_units_full) and bool(self.pool_ordered_unpacked[client_id]) and not bool(self.pool_empty):
            # retrive the id of the item and the item it self that is to be packed next (pool is an ordered dictionary). 
            current_item_id = list(self.pool_ordered_unpacked[client_id].keys())[0]
            current_item = self.pool_ordered_unpacked[client_id][current_item_id]
            
            # stop if item id has a not high enough prio
            if prio is not None and current_item.prio > prio:
                print("All items of prio position {} and higher are allready packed".format(prio))
                break

            # pack the current item in to the selected transport unit if enough space is available in that unit
            if current_trans_unit.cap_free <= current_item.cap:
                # setting unit to full if the available space is not sufficient.
                self.units_full[self.units_full.index(False)] = True
                try:
                    # select the next transport unit in the list that is not full yet
                    current_trans_unit = self.transport_units[list(self.transport_units.keys())[self.units_full.index(False)]]
                except ValueError:
                    self.all_units_full = True
                    print("Their is not not enough space left in the transport units")
            else: 
                # loading item and removing it from the pool
                self._load_item(client_id, current_item_id, current_item, current_trans_unit)
                self._remove_item_from_pool(client_id, current_item_id)

        return self.packed_vs_unpacked_cap(client_id, prio= 1), self.packed_vs_unpacked_cap(client_id, prio= 2), self.packed_vs_unpacked_cap(client_id, prio= 3)

    def packed_vs_unpacked_cap(self, client_id, prio=None):
        """ Calculates the capcity of the items that got allready packed and the items that got not packed yet

            Return:
                A tuple of format: (pack_cap, unpack_cap)
        """
        original_cap = self.client_items_cap(self.pool_ordered, client_id, prio)
        unpacked_cap = self.client_items_cap(self.pool_ordered_unpacked, client_id, prio)
        return original_cap-unpacked_cap, unpacked_cap

    def free_trans_cap(self, report=False):
        # calculates the free capacity in the transport units
        capacity = 0
        for unit in self.transport_units:
            capacity += self.transport_units[unit].cap_free
            if report:
                print("Transport unit {0} has {1} square meter free space left, {2} square meter are allready filled.".format(unit, self.transport_units[unit].cap_free, self.transport_units[unit].cap_used))
        return capacity

    
    def client_items_cap(self, pool, client_id, prio=None, order_id=None):
        """ Calculates the capcity of the items in a pool. The pool can either be the original self.pool_ordered
            or self.pool_ordered_unpacked. The calculation can be restricted to items with a given priority, order_id
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

    def full_items_cap(self, pool, prio=None):
        # calculates the capacity of all items in the pool. Can be restricted by the prio
        capacity = 0
        for client_id in pool:
            capacity += self.client_items_cap(pool, client_id, prio=prio)
        return capacity

    def _load_item(self, client_id, item_id, item, trans_unit):
        """ Writes the given item to the loaded_item_pool dictionary.
            Updates the free and used capcity of the transport unit.
        """
        try:
            # store the item in the trans unit
            trans_unit.loaded_item_pool[client_id][item_id] = item
        except KeyError:
            # Incase the client does not have items assigned to the unit yet initialize sub-dic first
            trans_unit.loaded_item_pool[client_id] = {}
            trans_unit.loaded_item_pool[client_id][item_id] = item
        trans_unit.add_cap(item.cap)

    def _remove_item_from_pool(self, client_id, item_id):
        # removes the item from pool_ordered_unpacked
        del self.pool_ordered_unpacked[client_id][item_id]




