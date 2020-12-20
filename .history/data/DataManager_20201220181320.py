import psycopg2

class DataManager:
    connection = None
    cursor = None
    dbname = "packlog"
    username = "postgres"
    password =  "asturias2009"

    def create(self):
        self.connect()
        self.cursor.execute('DROP TABLE artikel')
        self.cursor.execute('CREATE TABLE artikel(ArtNo INTEGER PRIMARY KEY, Bezeichnung VARCHAR, Laenge FLOAT, Breite FLOAT, Hoehe FLOAT, Gewicht FLOAT, VerpackId INTEGER, VerpackStueck INTEGER)')
        self.quit()

    def connect(self):
        self.connection = psycopg2.connect(dbname = self.dbname, user = self.username, password = self.password)
        self.cursor = self.connection.cursor()
        print()

    def quit(self):
        self.cursor.close()
        self.connection.close()

Manager = DataManager()
Manager.connect()
#DataManager.cursor.execute('SELECT * FROM artikel')
Manager.quit()