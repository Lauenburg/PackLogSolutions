from ..logic import Item, Order, TransportUnit


class Scheduler:

    def __init__(self, data_manager):
        self.data_manager = data_manager
        self.pool = {}

    def add_order_to_pool(self, item_query, quantity, client_id, order_id, date, out_date, prio):
        self._add_client_pool(client_id)
        self._add_item_to_pool(item_query, quantity, client_id, order_id, date, out_date, prio)

    def _add_client_pool(self, client_id):
        if client_id not in self.pool:
            self.pool[client_id] = {}

    def _add_item_to_pool(self, item_query, quantity, client_id, order_id, date, out_date, prio):
        # Check if client already ordered item. If yes update the quantity
        if item_query[0] not in self.pool[client_id]:
            self.pool[client_id][item_query[0]] = Item.from_item_query(item_query, quantity, client_id, order_id, date, out_date, prio) 
        else:
            self.pool[client_id][item_query[0]]["item"].quantity = self.pool[client_id][item_query[0]]["item"].quantity + quantity


    def order_client_pool(self, client_id):
        # Orders a all items of a client. First based on prio, second based on date.
        a = self.pool[client_id][104771]
        return sorted(self.pool[client_id], key=lambda k: (self.pool[client_id][k].prio, self.pool[client_id][k].out_date))
    
    
    
    ''' Deprecated
    def schedulePoolByDate(self, customer_id, pool_dict):
        """ Schedule Orders in Pool by Date 
            (earliest with the highest priority)
            input:  {order_id: (date, {item_id: (quantity, prio), ...}), ...}
        """
        # create list of orders from dict of order_ids
        order_list = []
        for order_id in pool_dict:
            out_date, item_dict = pool_dict[order_id]
            item_ids = item_dict.keys()
            item_specs = self.data_manager.getArticles(item_ids)
            order = Order.fromItemDict(order_id, customer_id, item_dict, item_specs, out_date)
            order_list.append(order)

        # sort orders by date
        order_list.sort(key=lambda order: order.out_date)

        return order_list
    '''

