# Python Backend

## REST api

### Interface
* `Schedular.add_order_to_pool()` adds an order to the schedular's order pool.
Schedular.pool:
```
{   
    client_id<1>: {item_id<i>:item_instance, ... ,item_id<j>:item_instance},
    ...,
    client_id<n>: {item_id<l>:item_instance, ... ,item_id<l>:item_instance}
}
```
* `Schedular.order_pool()` orders the schedular's order pool and writes it to pool_ordered.
Schedular.pool_ordered:
```
OrderedDict([ 
    (client_id<1>: {item_id<i>:item_instance, ... ,item_id<j>:item_instance}),
    ...,
    (client_id<n>: {item_id<l>:item_instance, ... ,item_id<l>:item_instance})
])
```


### Priorities
> 1:  High Prio (has to be delivered in next 3 days)

> 2:  Middle Prio (has to be delivered this month)

> 3:  Low Prio (no time pressure)

## logic

```python
from logic import Item, TransportUnit, Scheduler

# How to initialize the data objects
item            = Item(id=1, name="test_item", dimensions=[1., 1., 1.], weight=1.)
item            = Item.from_item_query(item_query)

# How to use scheduler
scheduler       = Scheduler(data_manager)
pool            = Scheduler.add_order_to_pool(item_query, quantity, client_id, order_id, date, out_date, prio):
pool_ordered    = Scheduler.order_pool()
```
