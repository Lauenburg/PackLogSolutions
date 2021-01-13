from flask import Flask, request
from flask_restful import Resource, Api

from ..logic import Scheduler
from ..data import DataManager
from .estimation import rough_estimation, fill_last_transport_unit

import json
import argparse
import random

### parse arguments ###
info = "Start PackLogSolutions Backend Server"
epilog = "EXAMPLE: python -m backend.api.api -dbname packlog -u postgres -p 1234"

parser = argparse.ArgumentParser(description=info, epilog=epilog)
parser.add_argument("-n", "--dbname", help="database name", type=str)
parser.add_argument("-u", "--username", help="username name", type=str)
parser.add_argument("-fa", "--file-article", help="article file name", type=str)
parser.add_argument("-ft", "--file-transobj", help="tansobj file name", type=str)
parser.add_argument("-p", "--password", help="user password", type=str, required=True)
parser.add_argument("-v", "--verbose", help="logging", action='store_true')
args = parser.parse_args()


app = Flask("PackLogAPI")
api = Api(app)

data_manager = DataManager(args.password, args.dbname, args.username, args.file_article, args.file_transobj)
data_manager.connect()

class Estimator(Resource):
    def post(self):
        # get data from post request
        data = request.get_json()

        # pre-process data to make consistent with backend (TODO: modify backend to be consistent)
        items = []
        for item in data["items_id_prio_quant"]:
            prio = int(item["id"]) if "prio" in item.keys() else random.randint(1,3)
            items.append((int(item["id"]), prio, int(item["quantity"])))
        data["items_id_prio_quant"] = items
        
        # process data & get estimate
        proportions = rough_estimation(data,data_manager)

        # data logging
        if args.verbose:
            app.logger.info(data)

        return proportions

class Packer(Resource):
    def post(self):
        # get data from post request
        data = request.get_json()

        # pre-process data to make consistent with backend (TODO: modify backend to be consistent)
        items = []
        for item in data["items_id_prio_quant"]:
            prio = int(item["id"]) if "prio" in item.keys() else random.randint(1,3)
            items.append((int(item["id"]), prio, int(item["quantity"])))
        data["items_id_prio_quant"] = items
        
        # process data & get estimate
        proportions = fill_last_transport_unit(data,data_manager)

        # data logging
        if args.verbose:
            app.logger.info(data)

        return proportions

api.add_resource(Estimator, '/estimator')
api.add_resource(Packer, '/packer')

if __name__ == '__main__':
    app.run(debug=True)