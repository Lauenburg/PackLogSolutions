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
        print(self.cursor.execute('SELECT 1'))

    def quit(self):
        self.cursor.close()
        self.connection.close()

try:
    Manager = DataManager()
    Manager.connect()
    #DataManager.cursor.execute('SELECT * FROM artikel')
    Manager.quit()
finally:
    Manager.quit()