from flask import Flask, request
from flask_restful import Resource, Api

from ..logic import Scheduler
from ..data import DataManager

import json
import argparse

### parse arguments ###
info = "Start PackLogSolutions Backend Server"
epilog = "EXAMPLE: python -m backend.api.api -dbname packlog -u postgres -p 1234"

parser = argparse.ArgumentParser(description=info, epilog=epilog)
parser.add_argument("-n", "--dbname", help="database name", type=str)
parser.add_argument("-u", "--username", help="username name", type=str)
parser.add_argument("-fa", "--file-article", help="article file name", type=str)
parser.add_argument("-ft", "--file-transobj", help="tansobj file name", type=str)
parser.add_argument("-p", "--password", help="user password", type=str, required=True)
args = parser.parse_args()


app = Flask("PackLogAPI")
api = Api(app)

data_manager = DataManager(args.password, args.dbname, args.username, args.file_article, args.file_transobj)
data_manager.connect()

class Estimator(Resource):
    def post(self):
        # get data from post request
        data = request.get_json()

        # process data & get estimate
        app.logger.info("Started data processing.")
        estimate = 0

        return {'estimate': estimate}

api.add_resource(Estimator, '/estimator')

if __name__ == '__main__':
    app.run(debug=True)