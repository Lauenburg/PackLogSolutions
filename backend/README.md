# Python Backend

## REST api

## logic

```
from logic import Item, Order, TransportUnit

item            = Item(id=1, name="test_item", dimensions=[1., 1., 1.], weight=1.)
ordered_items   = [item, item, item]
order           = Order(customer_id=11, item_list=ordered_items, prio=1, out_date=date.today())
transport       = TransportUnit(id=111, name="Truck", volume=40, weight=20)
```