import psycopg2

class DataManager:
    connection = NULL
    cursor = NULL
    dbname =

    def create():

    def connect():
        self.connection = psycopg2.connect(dbname = self.dbname, )
        self.cursor = self.connection.cursor()

    def quit():
