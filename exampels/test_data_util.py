from backend.data.data_util import read_from_xl, write_dic_to_json
from datetime import date


if __name__ == "__main__":
    json_dic = read_from_xl('/Users/lauenburg/Privat/CodeProjects/packlogsolutions/exampels/sample_orders/first_orders.xlsx', 
                            "order_one", ["quantity", "id", "name", "weight", "volume"])

    # Create order dic from parsed order
    order_one = {"client_id": 1001, "order_id": 34, "date": date.today(), "out_date": date(2021,2,1), "items_id_prio_quant": []}
    for item in json_dic:
        order_one["items_id_prio_quant"].append((int(item["id"]), None, int(item["quantity"])))

    print(order_one)

    # convert to json and write to file
    j = write_dic_to_json(json_dic, "/Users/lauenburg/Privat/CodeProjects/packlogsolutions/exampels/sample_orders/","order_one", "first_orders")
