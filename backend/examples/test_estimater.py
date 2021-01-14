import sys
sys.path.append('..')

from backend.data import DataManager
from backend.logic import Scheduler, Item, TransportUnit, Packer
from backend.logic.planning_util import free_trans_cap, client_items_cap, full_items_cap
from backend.data.data_util import read_from_xl, write_dic_to_json
from backend.api.estimation import fill_last_transport_unit

from datetime import date
import random
import argparse

parser = argparse.ArgumentParser(description="test schedular")
parser.add_argument("-n", "--dbname", help="database name", type=str)
parser.add_argument("-u", "--username", help="username name", type=str)
parser.add_argument("-fa", "--file-article", help="article file name", type=str)
parser.add_argument("-ft", "--file-transobj", help="tansobj file name", type=str)
parser.add_argument("-p", "--password", help="user password", type=str, required=True)
args = parser.parse_args()


order_one = {"client_id": 1001, "order_id": 34, "date": date.today(), "out_date": date(2021,1,1), 
            "items_id_prio_quant":[(104771, 1, 260), (780302, 2, 10000), (710702, 3, 1000), (727299, 2, 900), (750585, 1, 1000), (30320, 3, 1000), (730051, 1, 1000), (117471, 2, 1000)]}

transport1 = [{"id":23, "unit_type":"truck"},
                {"id":23, "unit_type":"small_truck"}]

if __name__ == "__main__":
    # create data manager instance and connect to DB
    man = DataManager(args.password, args.dbname, args.username, args.file_article, args.file_transobj)
    man.connect()

    print(fill_last_transport_unit(order_one, transport1, man))






