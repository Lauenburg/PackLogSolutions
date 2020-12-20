import psycopg2

class DataManager:
    connection = None
    cursor = None
    dbname = "packlog"
    username = "postgres"
    password =  "asturias2009"
    file_artikel = "data\Artikel_V1.csv"
    file_transObj = "data\TransObj_V1.csv"

    def reset(self):
        self.cursor.execute('DROP TABLE artikel')
        self.cursor.execute('DROP TABLE transObj')

    def create(self):       
            
        self.cursor.execute('CREATE TABLE artikel(ArtNo INTEGER PRIMARY KEY, Bezeichnung VARCHAR, Laenge FLOAT, Breite FLOAT, Hoehe FLOAT, Gewicht FLOAT, VerpackId INTEGER, VerpackStueck INTEGER)')
        with open(self.file_artikel, 'r') as f:
            next(f) 
            self.cursor.copy_from(f, 'artikel', sep=';')

        self.cursor.execute('CREATE TABLE transObj(Id INTEGER PRIMARY KEY, Bezeichnung VARCHAR, Laenge FLOAT, Breite FLOAT, Hoehe FLOAT, Gewicht FLOAT)')
        with open(self.file_transObj, 'r') as f:
            next(f) 
            self.cursor.copy_from(f, 'transObj', sep=';')

    def connect(self):
        self.connection = psycopg2.connect(dbname = self.dbname, user = self.username, password = self.password)
        self.cursor = self.connection.cursor()

    def quit(self):
        self.cursor.close()
        self.connection.close()

    def getArtikel(self, ids):
        artikel_list = []
        for id in ids:
            self.cursor.execute("SELECT * FROM artikel WHERE artno = " + str(id))
            artikel = self.cursor.fetchone()
            artikel_list.append(artikel)
        return artikel_list

    def getTransObjs(self, ids):
        transobjs_list = []
        for id in ids:
            self.cursor.execute("SELECT * FROM transobjs WHERE id = " + str(id))
            transobj = self.cursor.fetchone()
            transobjs_list.append(transobj)
        return transobjs_list

Manager = DataManager()
Manager.connect()
try:
    #Manager.reset()
    #Manager.create()
    print(Manager.getArtikel([722082, 722083]))
    print(Manager.ge)
    Manager.connection.commit()

finally:
    Manager.quit()
