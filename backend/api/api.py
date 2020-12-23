from flask import Flask, request
from flask_restful import Resource, Api

app = Flask("PackLogAPI")
api = Api(app)

class Estimator(Resource):
    def get(self):
        print(request.values)
        return {'estimate': request.values}

api.add_resource(Estimator, '/estimator')

if __name__ == '__main__':
    app.run(debug=True)