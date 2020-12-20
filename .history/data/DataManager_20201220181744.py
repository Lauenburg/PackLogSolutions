import psycopg2
import csv

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

    def create(self):       
        self.cursor.execute('CREATE TABLE artikel(ArtNo INTEGER PRIMARY KEY, Bezeichnung VARCHAR, Laenge FLOAT, Breite FLOAT, Hoehe FLOAT, Gewicht FLOAT, VerpackId INTEGER, VerpackStueck INTEGER)')
        with open('user_accounts.csv', 'r') as f:
            reader = csv.reader(f)
    next(reader) # Skip the header row.
    for row in reader:
        cur.execute(
        "INSERT INTO users VALUES (%s, %s, %s, %s)",
        row
    )

    def connect(self):
        self.connection = psycopg2.connect(dbname = self.dbname, user = self.username, password = self.password)
        self.cursor = self.connection.cursor()

    def quit(self):
        self.cursor.close()
        self.connection.close()

Manager = DataManager()
Manager.connect()
#DataManager.cursor.execute('SELECT * FROM artikel')
Manager.quit()
