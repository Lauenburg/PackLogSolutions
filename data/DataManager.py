import psycopg2

class DataManager:
    
    def __init__(self, password, dbname=None, username=None, file_artikel=None, file_transObj=None, connection=None, cursor=None):
        
        # fill in your specs
        self.connection = connection
        self.cursor = cursor
        self.dbname = "packlog" if dbname == None else dbname
        self.username = "postgres" if username==None else username
        self.password =  password
        self.file_artikel = "data/Artikel_V1.csv" if file_artikel==None else file_artikel
        self.file_transObj = "data/TransObj_V1.csv" if file_transObj==None else file_transObj


    # resetting of tables -> needs to be executed before recreating table
    def reset(self):
        self.cursor.execute('DROP TABLE artikel')
        self.cursor.execute('DROP TABLE transObj')


    # creating of tables and reading of data -> needs to be executed at the beginning anf for reading updated files
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


    # takes list of artikel-ArtNos and returns list of artikel tuples
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


# manager = DataManager("<yourpassword>")
# manager.connect()
# try:
# ############## WRITE CODE ##############


# ############## WRITE CODE ##############
#     manager.connection.commit()
# finally:
#     manager.quit()
