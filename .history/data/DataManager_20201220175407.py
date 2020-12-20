import psycopg2

class DataManager:
    connection = NULL
    cursor = NULL
    dbname = "packlog"
    username = "postgres"
    password =  "asturias2009"

    def create():

    def connect():
        self.connection = psycopg2.connect(dbname = self.dbname, user = self.username, password = self.password)
        self.cursor = self.connection.cursor()

    def quit():
        self.cursor.close()
        self.connection.close()
