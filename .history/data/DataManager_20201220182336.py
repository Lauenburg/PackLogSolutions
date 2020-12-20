import psycopg2

class DataManager:
    connection = None
    cursor = None
    dbname = "packlog"
    username = "postgres"
    password =  "asturias2009"
    file_artikel = ""
    file_trans = ""

    def reset(self):
        self.cursor.execute('DROP TABLE artikel')
        self.connection.commit()


    def create(self):       
        self.cursor.execute('CREATE TABLE artikel(ArtNo INTEGER PRIMARY KEY, Bezeichnung VARCHAR, Laenge FLOAT, Breite FLOAT, Hoehe FLOAT, Gewicht FLOAT, VerpackId INTEGER, VerpackStueck INTEGER)')
        with open(self.file_artikel, 'r') as f:
            next(f) # Skip the header row.
            self.cursor.copy_from(f, 'Artikel', sep=';')
        self.cursor.commit()

    def connect(self):
        self.connection = psycopg2.connect(dbname = self.dbname, user = self.username, password = self.password)
        self.cursor = self.connection.cursor()

    def quit(self):
        self.cursor.close()
        self.connection.close()

Manager = DataManager()
Manager.connect()
try:
 Manager.create()

Manager.quit()
