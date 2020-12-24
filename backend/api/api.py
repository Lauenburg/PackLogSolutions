from flask import Flask, request
from flask_restful import Resource, Api

from ..logic import *
# from ...data import DataManager

import json

app = Flask("PackLogAPI")
api = Api(app)

# data_manager = DataManager(args.password, args.dbname)

class Estimator(Resource):
    def post(self):
        # get data from post request
        data = request.get_json()

        # process data & get estimate
        estimate = 0

        return {'estimate': estimate}

api.add_resource(Estimator, '/estimator')

if __name__ == '__main__':
    app.run(debug=True)