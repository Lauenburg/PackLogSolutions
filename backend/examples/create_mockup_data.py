import json
import random
import numpy as np
from datetime import date

def chunks(lst, n):
    """Yield successive n-sized chunks from lst."""
    for i in range(0, len(lst), n):
        yield lst[i:i + n]

Warenempfänger = [{'id': 1, 'WEN': 'AX125D', 'customer': 'PERI Deutschland', 'items': []}, \
    {'id': 2, 'WEN': 'AX327A', 'customer': 'PERI Australien', 'items': []}, \
    {'id': 3, 'WEN': 'AX426F', 'customer': 'PERI Frankreich', 'items': []}]

order_ids = 1000 + np.random.choice(8999,20,replace=False)
dates = [{'y': 2021, 'm': random.randint(2,12), 'd': random.randint(1,29)} for i in range(20)]

if __name__ == "__main__":

    with open('./sample_orders/first_orders_order_one.json') as json_file:
        order = json.load(json_file)

    ids = np.random.choice(len(order), len(order), replace=False)
    ids = list(chunks(ids.astype(int), 20))

    count = 0
    for WNF in Warenempfänger:
        for i in range(min(3, len(ids)-count)):
            ids_ = ids[count]
            count += 1
            order_ = [order[index] for index in ids_]
            order_id = int(order_ids[count])
            date = dates[count]
            for item in order_:
                item["order_id"] = order_id
                item["out_date"] = date
                item["draft_id"] = None
                item["draft_date"] = None
                item["request_id"] = None
                item["request_date"] = None
            WNF["items"].extend(order_)

    j = json.dumps(Warenempfänger)
    with open('./sample_orders/mockup_data.json', 'w') as f:
        f.write(j)
                
    


