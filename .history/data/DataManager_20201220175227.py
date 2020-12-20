import psycopg2

class DataManager:
    connection = NULL
    cursor = NULL
    dbname =
    username =
    self

    def create():

    def connect():
        self.connection = psycopg2.connect(dbname = self.dbname, user = self.username, password = self.password )
        self.cursor = self.connection.cursor()

    def quit():
