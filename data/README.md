
# Database Setup

1. Make sure Postgresql is installed
2. Create database "packlog" using sqlshell or pgadmin4 (installed with postgresql)
3. Run `setup_database.py` script in packlogsolutions folder
   ```
    python setup_database.py --dbname ... -u username -p password
   ```
4. Now you can fetch Articles and transObjs from the database
   ```
    from data.DataManager import DataManager

    manager = DataManager("<password>")
    manager.connect()

    item_specs = manager.getArticles(id)
   ```

# Data

## Item Specifications

## Historic Order Data
