import psycopg2

class DataManager:
    
    # fill in your specs
    connection = None
    cursor = None
    dbname = "packlog"
    username = "postgres"
    password =  ""
    file_artikel = "data\Artikel_V1.csv"
    file_transObj = "data\TransObj_V1.csv"


    # resetting of tables -> needs to be executed before recreating table
    def reset(self):
        self.cursor.execute('DROP TABLE artikel')
        self.cursor.execute('DROP TABLE transObj')


    # creating of tables and reading of data -> needs to be executed at the beginning anf for reading n
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


    # takes list of artikel-artno and returns list of artikel tuples
    def getArtikel(self, ids):
        artikel_list = []
        for id in ids:
            self.cursor.execute("SELECT * FROM artikel WHERE artno = " + str(id))
            artikel = self.cursor.fetchone()
            artikel_list.append(artikel)
        return artikel_list


    # takes list of tranobj-ids and returns list of transobj tuples
    def getTransObjs(self, ids):
        transobjs_list = []
        for id in ids:
            self.cursor.execute("SELECT * FROM transobj WHERE id = " + str(id))
            transobj = self.cursor.fetchone()
            transobjs_list.append(transobj)
        return transobjs_list


Manager = DataManager()
Manager.connect()
try:
############## WRITE CODE ##############


############## WRITE CODE ##############
    Manager.connection.commit()
finally:
    Manager.quit()
