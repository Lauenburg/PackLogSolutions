import psycopg2

from psycopg2.extensions import ISOLATION_LEVEL_AUTOCOMMIT
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
        cursor.close()
        connection.close()


