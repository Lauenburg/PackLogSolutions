from ..logic import Item, Order, TransportUnit


class Scheduler:

    def __init__(self, data_manager):
        self.data_manager = data_manager

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
            item_specs = self.data_manager.getArtikel(item_ids)
            order = Order.fromItemDict(order_id, customer_id, item_dict, item_specs, out_date)
            order_list.append(order)

        # sort orders by date
        order_list.sort(key=lambda order: order.out_date)

        return order_list