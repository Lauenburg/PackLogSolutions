import psycopg2

class DataManager:
    connection = None
    cursor = None
    dbname = "packlog"
    username = "postgres"
    self.password =  "asturias2009"

    def create():
        return

    def connect():
        self.connection = psycopg2.connect(dbname = self.dbname, user = self.username, password = self.password)
        self.cursor = self.connection.cursor()

    def quit():
        self.cursor.close()
        self.connection.close()
