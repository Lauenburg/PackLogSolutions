from . import Item, TransportUnit
from .planning_util import free_trans_cap, client_items_cap, full_items_cap, ceil
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
        self.eps = 1e-10


    def load_client_items(self, client_id, prio=None):
        """ Packs all items in the item pool corresponding to the client id in to the available transport units.
            The function stops packing when either all items with priority < prio got packed, all items in the customer item pool 
            got packed or all transport units are full.  

            Returns:
                A tuple of tuples of format: ((pack_cap_prio_1,unpack_cap_prio_1),(pack_cap_prio_2,unpack_cap_prio_2),(pack_cap_prio_3,unpack_cap_prio_3))
        """
        
        # Calculate the still available free capacity of the transport units and the capacity of the unpacked items.
        free_cap = free_trans_cap(self.transport_units)
        item_cap = 0
        if prio is not None:
            for i in range(prio):
                item_cap += client_items_cap(self.pool_ordered_unpacked, client_id, i+1)
        else:
            item_cap = client_items_cap(self.pool_ordered_unpacked, client_id)
        print("Currently free transportation capacity: ", free_cap)
        print("Capacity of the items scheduled for packing: ", item_cap)

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

        return self._packed_vs_unpacked_cap(client_id, prio= 1), self._packed_vs_unpacked_cap(client_id, prio= 2), self._packed_vs_unpacked_cap(client_id, prio= 3)

    def fit_capacities(self, client_id):
        """ Fits the item volume to the free transport volume based on priority. 
            First tries to fit all items of prio one, followed by two, followed by three.

            Returns:
                A list of tuples. Each tuple is comprised of "items volume of prio x" that fit the transport units and
                "items volume of prio x" that do not fit the transport unit. The order is prio one, two, three.
                Example output, assumeing that all items fit: [(cap_prio_1, 0), (cap_prio_2, 0), (cap_prio_3, 0)]
        """
        transport_cap = free_trans_cap(self.transport_units)
        # initialize matched capacity list with all items unpacked 
        matched_cap = [(0,client_items_cap(self.pool_ordered,client_id, prio=1)),
                        (0,client_items_cap(self.pool_ordered,client_id, prio=2)),
                        (0,client_items_cap(self.pool_ordered,client_id, prio=3))]
        for item in self.pool_ordered[client_id].values():
            if item.cap <= transport_cap:
                matched_cap[item.prio-1] = (matched_cap[item.prio-1][0]+item.cap, 
                                            matched_cap[item.prio-1][1]-item.cap if matched_cap[item.prio-1][1]-item.cap > self.eps else 0)
                transport_cap -= item.cap
        return matched_cap

    def _packed_vs_unpacked_cap(self, client_id, prio=None):
        """ Calculates the capcity of the items that got allready packed and the items that got not packed yet

            Return:
                A tuple of format: (pack_cap, unpack_cap)
        """
        original_cap = client_items_cap(self.pool_ordered, client_id, prio)
        unpacked_cap = client_items_cap(self.pool_ordered_unpacked, client_id, prio)
        key_first = next(iter(self.transport_units.keys()))
        volume = self.transport_units[key_first].volume
        return (original_cap-unpacked_cap)/volume, unpacked_cap/volume
        # return ceil(100/original_cap * (original_cap-unpacked_cap), 2), ceil(100/original_cap * unpacked_cap,2)

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




