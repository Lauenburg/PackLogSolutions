# Python Backend

## REST api

### Interface
* `startQuery()` provides the following data to the backend
item_dict:
```
{   
    item_id: {date: ..., order_id: ..., quantity: ..., prio: ...},
    ...,
    item_id: {date: ..., order_id: ..., quantity: ..., prio: ...}
}
```

### Priorities
> 1:  Low Prio (no time pressure)

> 2:  Middle Prio (has to be delivered this month)

> 3:  High Prio (has to be delivered in next 3 days)

## logic

```python
from logic import Item, Order, TransportUnit, Scheduler

# How to initialize the data objects
item            = Item(id=1, name="test_item", dimensions=[1., 1., 1.], weight=1.)
item            = Item.from_item_query(item_query)
ordered_items   = [item, item, item]
order           = Order(customer_id=11, item_list=ordered_items, prio=1, out_date=date.today())
transport       = TransportUnit(id=111, name="Truck", volume=40, weight=20)

# How to use scheduler
scheduler       = Scheduler(data_manager)
sorted_orders   = scheduler.schedulePoolByDate(customer_id, order_dict)
```
