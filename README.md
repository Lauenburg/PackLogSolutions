# PackLog Rough Estimation

## Introduction
Every day, logistics companies deal with the task of packing their goods into the appropriate transport vehicles in order to deliver them to the end customer. This requires forward planning and careful communication between the individual parties, starting with the customer service and planner to the packer and final logistic operator. This whole process is very complex, requires many iterations and involves many unknowns. Also the planning problem on how to pack all items into the transport vehicles is far from trivial as it involves all kinds of variations and constraints. Maximum weight, Maximum space and balanced axis distribution, just to name a few. So far, this complexity can only be handled by human brianpower. Using machine intelligence to support this complex problem would only be feasible and beneficial if the whole process is digitalized, so that the optimized planning for a given order can also be passed on to the packer and modifications would take affect immediately. In order to make such a holistic approach feasible, a step-by-step approach is most appropiate.

In cooperation with our partner companies (PERI, Hilti, ...) we discovered that the greatest added value of a digital solution can already be achieved in the rough planning stage. The rough planning stage takes place directly after the customer service has received an order from the customer. For every order, the customer service needs a rough estimate of the required transport units in order to book them and also to give feedback to the customer to adjust the order if the oder would only fill half a truck. This currently involves consultation of the planner and a feedback delay of up to 3 days. Imagine iterating over this several times. 


## Rough Estimation Tool
Therefore we developed a rough estimation tool that allows the customer service to get an transport unit estimate immediately by simply selecting the respective order. o
Our solution consists of a clearly structured user interface that can be accessed from everywhere and on any device (Phone, Tables, Web, Desktop). The intelligent planning algorithms will be provided by a central server that can be access from the frontend (UI) through well-defined API calls. This facilitates easy accessibility and simple updates of the planning models.

In the following we will describe the whole platform architecture, consisting of a frontend and backend and all of its components in detail.

<br></br>

## Getting Started

### Requirements

* [Install Anaconda](https://docs.anaconda.com/anaconda/install/)

### Installation

1. Clone Repository
```
git clone https://gitlab.lrz.de/lupries/packlogsolutions.git
cd packlogsolutions
```

2. Setup Virtual Python Environment
```
conda update conda
conda create --name packlog python=3.8
conda activate packlog
conda install --file requirements.txt
```
after you have installed new python packages, update requirements.txt file:
```
conda list --explicit > requirements.txt
```

### Start Backend Server

The following command will start a local server (http://127.0.0.1:5000/) hosting the backend API:
```
python -m backend.api.api -n "database_name" -p "password"
```

### Start Frontend

- [Install Flutter (Beta)](https://flutter.dev/docs/get-started/install)
- [Install Chrome]()
```
flutter config --enable-web
flutter devices     # check if chrome is avalable
flutter run -d chrome
flutter build web
```

<br></br>

## Things used in this project

### Programming Languages

<img src="https://assets.stickpng.com/images/5848152fcef1014c0b5e4967.png" alt="drawing" width="15"/> [Python](https://www.python.org/)

<img src="https://avatars.githubusercontent.com/u/1609975?s=280&v=4" width="15"/> [Dart](https://dart.dev/)

<img src="https://img.favpng.com/11/4/14/microsoft-sql-server-computer-icons-oracle-corporation-oracle-database-png-favpng-k4KjYieuYpSdy2bxiud63NBP2.jpg" width="15"/> [SQL](https://dart.dev/)

### Frameworks

<img src="https://www.pngfind.com/pngs/m/62-626422_python-logo-clipart-drawing-flask-hd-png-download.png" alt="drawing" width="13"/> [Flask RESTful API](https://flask-restful.readthedocs.io/en/latest/)

<img src="https://assets.stickpng.com/images/584815fdcef1014c0b5e497a.png" alt="drawing" width="15"/> [PostgreSQL Database](https://www.postgresql.org/)

<img src="https://www.kindpng.com/picc/m/355-3557482_flutter-logo-png-transparent-png.png" alt="drawing" width="15"/> [Flutter UI Framework](https://flutter.dev/)

### Platforms

<img src="https://assets.stickpng.com/images/5847f40ecef1014c0b5e488a.png" alt="drawing" width="12"/> [Firebase Hosting](https://firebase.google.com/docs/hosting)

<img src="https://avatars.githubusercontent.com/u/4868969?s=280&v=4" alt="drawing" width="12"/> [Scalingo Cloud Hosting](https://scalingo.com/)

<br></br>

## Code Repository ([GitLab](https://gitlab.lrz.de/lupries/packlogsolutions))

`data` - directory for datasets

`backend` - directory for python backend and api

`frontend` - directory for flutter ui

<br></br>

## Architecture Overview

<div style="text-align:center"><img src="images/overview.png" alt="Screenshot-2021-01-27-134921" border="0" width=400></div>

The architecture overview presents the frontend and backend and visualizes the communication pathways via the API. Note that integration of other APIs such as SAP is possible via the API layer. In the following, we start by describing the backend.

<br></br>

## Backend
The backend represents the brain of our platform as it holds the whole logic to calculate our rough planning estimate. For a modular structure and simplistic design we choose Python as programming language to handle all computations in the backend.

>#### [Python](https://www.python.org/) <img src="https://assets.stickpng.com/images/5848152fcef1014c0b5e4967.png" alt="drawing" width="15"/>
>Python is an interpreted, object-oriented, high-level programming language which has simple and easy to learn syntax. It emphasizes readability and therefore reduces the cost of program maintenance. Further, Python supports modules and packages, which encourages program modularity and code reuse. Python is therefore the right choice to programm our modular estimation logic in the backend. We use Python to setup the communication with the front-end and process incoming lists of data. It allows us to performing math calculations and incorporate common machine learning frameworks.

#### Entities
In the backend we created object classes of all relevant entities such as `Item, Order, TransportUnit`. Code can be found unter `backend/logic`.

```
# How to initialize data objects
item            = Item(id=1, name="test_item", dimensions=[1., 1., 1.], weight=1.)
item            = Item.from_item_query(item_query)
```

Several modules are needed to process the incoming order data.

#### DataManager
First, the `DataManager` is responsible for quering all relevant data about the items (weight, volume, material, ...) from the database (described below). 

```
# How to use DataManager
data_manager = DataManager(password, dbname, username)
data_manager.connect()
```

#### Scheduler
Afer having constructed parameterized objects of all items in the order list, the `Scheduler` structures all items based on the recipient and sorts all items based on priorities and delivery date.

```
# How to use scheduler
scheduler       = Scheduler(data_manager)
pool            = scheduler.add_order_to_pool(item_query, quantity, client_id, order_id, date, out_date, prio)
pool_ordered    = scheduler.order_pool()
```

#### Packer
Finally, the `Packer` gets the ordered item lists and uses several iterative algorithms to pack items into the relevant transport units and returns an estimate of the required number of units for the requested order.

```
# How to use the packer
packer                  = Packer(transport_units, pool_ordered)
free_trans_cap          = packer.free_trans_cap(report=True)
pool_item_cap           = packer.full_items_cap(pool, prio=None)
client_items_cap        = packer.client_items_cap(pool, client_id, prio=None, order_id=None)
```

The backend also includes a database which holds all relevant data of the items such as id, name, weight, volume and material. We therefore choose a popular SQL database to store this information. The connection to the backend code established by SQL queries that can be made using the python package `psycopg2`.
>#### [PostgreSQL Database](https://www.postgresql.org/) <img src="https://assets.stickpng.com/images/584815fdcef1014c0b5e497a.png" alt="drawing" width="15"/>
>PostgreSQL is a powerful, open source object-relational database system which has earned a strong reputation for reliability, feature robustness, and performance. PostgreSQL lets you setup professional SQL databases and is widely supported for hosting databases in the cloud. We choose PostgreSQL to create a professional database of all Item information that can easily be deployed to our cloud environment.

### REST API
As described in the architectue overview, our backend is communicating to the frontend via an a REpresentational State Transfer (REST) API. This allows us to get the planning estimate by simply sending a (http) POST request attached with the order information. In return the Backend API will reply with a return message including the final estimate. We used the Flask RESTful framework to setup the appropriate request endpoints. A detailed description of the API calls can be found in API Documentation section below. Code can be found under `backend/api`.

>#### [Flask RESTful API](https://flask-restful.readthedocs.io/en/latest/) <img src="https://www.pngfind.com/pngs/m/62-626422_python-logo-clipart-drawing-flask-hd-png-download.png" alt="drawing" width="13"/>
>Flask-RESTful is an extension for Flask (web development framework) that adds support for quickly building REST APIs. It is a lightweight abstraction that works with our backend and database.

### Backend Hosting
To make our backend service accessible via the API, we need to deploy and run it to a server platform. There are hundreds of cloud platforms out there and we choose Scalingo as of them for the purpose of this demo. For a detailed describtion on how to deploy your code to the server environment and setup the database on the server we refer to the [Scalingo Documentation](https://doc.scalingo.com/).

>#### [Scalingo Cloud Hosting](https://scalingo.com/) <img src="https://avatars.githubusercontent.com/u/4868969?s=280&v=4" alt="drawing" width="12"/>
>Scalingo offers Automatic Cloud Hosting which allows for easy setup and deployment of a server in the cloud. We use this platform to host our python backend API.

## Frontend

The User Interface represents the graphical interface through which the user can interact with the platform. We require it to be well-structured, easy to use and fast-responsive. Since the user should be able to access the platform from any device and location we decided to go with a the cross-platform development framework Flutter which allows us to deploy target applications for all platforms (including the web) with a single codebase.

>#### [Flutter UI Framework](https://flutter.dev/) <img src="https://www.kindpng.com/picc/m/355-3557482_flutter-logo-png-transparent-png.png" alt="drawing" width="15"/>
>Flutter is a cross-platform User Interface (UI) toolkit for building beautiful, natively compiled applications for mobile, web, and desktop from a single codebase. The framework allows to build fully-customizable widgets in a layered achitecture. A major advatage is that one developed codebase can be compiled to deploy a webapp, desktop as well as ios and android apps.

All developed views and a short description can be found below.

<br></br>

### Landing Page View

<div style="text-align:center"><img src="images/image9.png" alt="image9" border="2" width=500></div>

>User: Customer Service, Planner

The Lading Page gives access to the appropriate user via a Login Screen.

### Recipients Overview

<div style="text-align:center"><img src="images/image10.png" alt="image10" border="2" width=500></div>

>User: Customer Service

This view lists all the recipients including the current status of the orders and additional information. Each recipient can be selected to view the ordered items.

### Orders View

<div style="text-align:center"><img src="images/image7.png" alt="image7" border="2" width=500></div>

>User: Customer Service

This view depicts the order pool of a selected recipient. The user can select different items manually. He can sort the pool based on the different column categories, e.g. `Prio` and eventually select all items by checking the top left box.
Having selected a set of items we can click on the `Plan` Button in the top right corner.

### Confirm Selection View

<div style="text-align:center"><img src="images/image3.png" alt="image3" border="2" width=500></div>

>User: Customer Service

Having selected a set of items from a recipients item pool, and after clicking on `Plan` in the top right corner, this view depicts the selection of items and asks for confirmation. This forwards us to the `Planning Draft View`.

### Planning Draft View

<div style="text-align:center"><img src="images/image2.png" alt="image2" border="2" width=500></div>

>User: Customer Service

This view depicts how many vehicles of the given type are needed to fit all items with prio one. The fittet items are marked in green. The three bars on the bottom right depict (left to right) the number of fully packed transport vehicles, the space utilisation of the last (not fully packed) vehicle, the capacity of the so far unpacked items of prio two (light blue) and prio three (dark blue). 

<div style="text-align:center"><img src="images/image1.png" alt="image1" border="2" width=500></div>

To utilize the space of the vehicle that is not fully packed yet, we can click on the `Click for Optimization` button on the bottom right corner. 
In the background the frontend now sends an http request to the backend server attached with all the selected item ids. In the Backend, our intelligent logistic engine now fits as many of the items of prio two (light blue) and prio three (dark blue) into the free space. The items which fitted the last truck are depicted in orange.

We can now either select `Save` or `Request Planner` in the top right view. Selecting save we return to the `Recipients Overview` and can start planning the next order. Selecting `Request Planner` we also get redirected to the `Recipients Overview` however in this case the order now appears on the `Planner Request View` and is still pending for confirmation by a planner.

### Planner Request View

<div style="text-align:center"><img src="images/image8.png" alt="image8" border="2" width=500></div>

>User: Planner

As the planner I can log into Packlog and check on the `Planner Request View` which orders need to be confirmed by a planner. The view lists all the orders of recipients that have to be double checked.

### Planner Confirmation View

<div style="text-align:center"><img src="images/image11.png" alt="image11" border="2" width=500></div>

>User: Planner

After selecting an order that is pending for confirmation: The planner can remove items from the order and adjust all other values, like the number of trucks needed. In the top right corner the planner can either delete the draft or save it.  
Clicking save or delete the planner is redirected to the `Planner Request View` where he can check the next order in need of confirmation.

### Frontend Hosting

For the purpose of this prototype, we deploy our User Interface as a web application that can be accessed via a browser. Note that it is also possible to deploy the Interface as a mobile or desktop application. To host the web application on a public domain we use the Firebase platform which is just one of many website hosting platforms.

>#### [Firebase Hosting](https://firebase.google.com/docs/hosting) <img src="https://assets.stickpng.com/images/5847f40ecef1014c0b5e488a.png" alt="drawing" width="12"/> 
>Firebase Hosting provides fast and secure hosting for our web app. We choose Firebase Hosting because it allows us to quickly deploy our web app and serve both static and dynamic content to the web. Firebase offers a free pricing plan that is sufficient to serve our User Interface in the prototyping stage and easy upgradable to a 'pay as you go' plan.

<br></br>

## API Documentation

The API is organized around REST. Our API has predictable resource-oriented URLs, accepts form-encoded request bodies, returns JSON-encoded responses, and uses standard HTTP response codes.

### Estimator

|  | |
|--------|--------|
| Type: | POST |
| URL: | `http://127.0.0.1:5000/estimator` |
| Body_type: | json |
| Response_type: | json |

Example body:

```
{
    "client_id": 1, "order_id": 2, "date": (1,1,20), "out_date": (1,1,20), "transport_unit": "truck", 
    "items_id_prio_quant": [
        {"quantity": 8.0, "id": 118737.0, "prio": 1},
        {"quantity": 31.0, "id": 22560.0, "prio": 2}]
}
```

Example response:

```
{
    "estimate": {
        "1": [0.72, 0.0],
        "2": [0.0, 0.75],
        "3": [0.0, 0.84]
    }
}
```

### Packer

|  | |
|--------|--------|
| Type: | POST |
| URL: | `http://127.0.0.1:5000/packer` |
| Body_type: | json |
| Response_type: | json |

Example body:

```
{
    "client_id": 1, "order_id": 2, "date": (1,1,20), "out_date": (1,1,20), "transport_unit": "truck", 
    "items_id_prio_quant": [
        {"quantity": 8.0, "id": 118737.0, "prio": 1},
        {"quantity": 31.0, "id": 22560.0, "prio": 2}]
}
```

Example response:

```
{
    "estimate": {
        "1": [0.72, 0.0],
        "2": [0.26, 0.48],
        "3": [0.0, 0.84]
    },
    "n_items_last": [
        112133,
        23170,
        25730,
    ]
}
```

<br></br><br></br>

## Examples/Tests

### Send POST requests to API

Start Backend server and execute test script:
```
python -m backend.api.test_api 
```

### Test logic functions

```
python -m backend.examples.test_schedular -n "database_name" -p "password"
python -m backend.examples.test_packer -n "database_name" -p "password"
```
