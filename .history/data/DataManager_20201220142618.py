import psycopg2

class DataManager:
    connection = NULL
    cursor = NULL
    host = "localhost",
    database = "packlog",
    user = "postgres",
    password = "",
    port = 5432

    def setup():


    def connect():
        connection = psycopg2.connect(host,database,user,password,port)
        cursor = connection.cursor()


    def close():
        cur.close()
        connection.close()


con = psycopg2.connect(
    host = "localhost",
    database = "packlog",
    user = "postgres",
    password = "",
    port = 5432
)


cur.execute()


