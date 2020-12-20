import psycopg2

class DataManager:
    connection = NULL
    cursor = NULL

    def setup():


    def connect():

        con = psycopg2.connect(
            host = "localhost",
            database = "packlog",
            user = "postgres",
            password = "",
            port = 5432
        )

    def close():



con = psycopg2.connect(
    host = "localhost",
    database = "packlog",
    user = "postgres",
    password = "",
    port = 5432
)

cur = con.cursor()

cur.execute()


