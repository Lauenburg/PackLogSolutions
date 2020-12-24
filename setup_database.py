import argparse
from backend.data import DataManager

info = "Load data into database script"
epilog = "EXAMPLE: python setup_database.py -dbname packlog -u postgres -p 1234"

if __name__=="__main__":
    parser = argparse.ArgumentParser(description=info, epilog=epilog)
    parser.add_argument("-n", "--dbname", help="database name", type=str)
    parser.add_argument("-u", "--username", help="username name", type=str)
    parser.add_argument("-fa", "--file-article", help="article file name", type=str)
    parser.add_argument("-ft", "--file-transobj", help="tansobj file name", type=str)
    parser.add_argument("-p", "--password", help="user password", type=str)
    args = parser.parse_args()

    assert args.password != None, "Please provide a password: -p <password>"

    manager = DataManager(args.password, args.dbname, args.username, args.file_article, args.file_transobj)
    manager.connect()
    manager.create()

    manager.connection.commit()
    manager.quit()

