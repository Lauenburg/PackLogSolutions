
con = psycopg2.connect(
    host = "localhost",
    database = "packlog",
    user = "postgres",
    password = "asturias2009",
    port = 5432
)

cur = con.cursor()

cur.execute()


cur.close()
con.close()