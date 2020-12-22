# Python Backend

## REST api

### Interface
* `startQuery()` provides the following data to the backend

order_dict:
```
{   
    order_id: (date, item_dict),
    ...,
    order_id: (date, item_dict)
}
```
item_dict:
```
{   
    item_id: (quantity, prio), 
    ..., 
    item_id: (quantity, prio)
}
```
## logic

```python
from logic import Item, Order, TransportUnit, Scheduler

# How to initialize the data objects
item            = Item(id=1, name="test_item", dimensions=[1., 1., 1.], weight=1.)
ordered_items   = [item, item, item]
order           = Order(customer_id=11, item_list=ordered_items, prio=1, out_date=date.today())
transport       = TransportUnit(id=111, name="Truck", volume=40, weight=20)

# How to use scheduler
scheduler       = Scheduler(data_manager)
sorted_orders   = scheduler.schedulePoolByDate(customer_id, order_dict)
```
