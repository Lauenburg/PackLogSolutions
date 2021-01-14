# PackLogSolutions

`data` - directory for datasets

`backend` - directory for python backend

`frontend` - directory for flutter ui

<br></br><br></br>

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

<br></br><br></br>

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

<br></br><br></br>

## Git Best Practices
(`master` is main branch, create new branch to make changes and merge)
```
git pull
git checkout -b <nameofbranch>
git push --set-upstream origin <nameofbranch>
(make some changes, add/delete files)
git add *
git commit -m "<some text describing your changes>"
git checkout master
git merge <nameofbranch>
(if git merge fails -> exit popup ':q' -> resolve highlighted conflicts in files -> commit again)
git push
```

