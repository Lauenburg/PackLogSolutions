from datetime import date
from .item import Item

class Order:

    def __init__(self, customer_id, item_list=[], prio=0, out_date=date.max):

        assert type(customer_id) == int, "id is not an integer: %r is of type %r" % (customer_id, type(customer_id))
        assert type(item_list) == list, "item_list is not a list: %r is of type %r" % (item_list, type(item_list))
        assert all([type(item)==Item for item in item_list]), "elements in items are not Item objects"
        assert type(prio) == int or len(prio) == len(items), "prio should be a list of same length as items or one number"
        assert type(out_date) == date, "date is not a date object: %r is of type %r" % (out_date, type(date))

        self.customer_id = customer_id
        self.items = item_list
        self.prio = prio
        self.out_date = date

    def __len__(self):
        return len(self.items)

    def __iter__(self):
        return iter(self.items)