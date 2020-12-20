import psycopg2

class DataManager:
    connection = None
    cursor = None
    dbname = "packlog"
    username = "postgres"
    password =  "asturias2009"

    def create(self):
        return

    def connect(self):
        self.connection = psycopg2.connect(dbname = self.dbname, user = self.username, password = self.password)
        self.cursor = self.connection.cursor()

    def quit(self):
        self.cursor.close()
        self.connection.close()


Manager = DataManager()
Manager.connect()
Manager.quit()