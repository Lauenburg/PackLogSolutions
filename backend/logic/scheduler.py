from ..logic import Item, TransportUnit
import collections


class Scheduler:

    def __init__(self, data_manager):
        self.data_manager = data_manager
        self.pool = {}
        self.pool_ordered = collections.OrderedDict()

    def add_order_to_pool(self, item_query, quantity, client_id, order_id, date, out_date, prio):
        """ Takes an order and adds the items from the order to the clients subpool with in self.pool (see: _add_item_to_pool).
            If the client does not have its own subpool with in self.pool yet, a subpool gets initialized (see: _add_client_pool).

            Input:
                item_query: Out put of the data base query DataManager.getArticle(item_id)
                quantity: Ordered quantity of an item
        """
        self._add_client_pool(client_id)
        self._add_item_to_pool(item_query, quantity, client_id, order_id, date, out_date, prio)

    def _add_client_pool(self, client_id):
        # Creates client pool if the client does not have its own subpool with in self.pool yet.
        if client_id not in self.pool:
            self.pool[client_id] = {}

    def _add_item_to_pool(self, item_query, quantity, client_id, order_id, date, out_date, prio):
        # Adds the items of an order to the client subpool. If the item is allready listed its quantity gets updated
        if item_query[0] not in self.pool[client_id]:
            self.pool[client_id][item_query[0]] = Item.from_item_query(item_query, quantity, client_id, order_id, date, out_date, prio) 
        else:
            self.pool[client_id][item_query[0]]["item"].quantity = self.pool[client_id][item_query[0]]["item"].quantity + quantity

    def order_pool(self):
        # Creates an ordered version of self.pool with in self.pool_ordered (see: _ordered_item_list and _ordered_client_dict)
        client_ids = list(self.pool.keys())
        for cl_id in client_ids:
            ord_item_list = self._ordered_item_list(cl_id)
            self._ordered_client_dict(cl_id, ord_item_list)

    def _ordered_item_list(self, client_id):
        """ Orders the subpool of a client. First based on prio, second based on date. 
            Example for five instances of type (item_id, prio, out_date): 
                Unordered: (15322, 2, 21/12/20), (53222, 1, 25/12/20), (34821, 3, 04/01/21), (66632, 1, 01/01/21), (99332, 2, 19/12/20)
                Ordered:   (53222, 1, 25/12/20), (66632, 1, 01/01/21), (99332, 2, 19/12/20), (15322, 2, 21/12/20), (34821, 3, 04/01/21)
        """
        return sorted(self.pool[client_id], key=lambda k: (self.pool[client_id][k].prio, self.pool[client_id][k].out_date))
    
    def _ordered_client_dict(self, client_id, ordered_list):
        # Given a client id and the list for the correct order of the items, creates a ordered subpool with in self.pool_ordered
        self.pool_ordered[client_id] = {}
        for item_id in ordered_list:
            self.pool_ordered[client_id][item_id]= self.pool[client_id][item_id]
        print(self.pool_ordered[client_id])
