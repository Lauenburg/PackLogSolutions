import psycopg2

con = psycopg2.connect(
    host = "localhost",
    database = "packlog",
    user = "postgres",
    password = "asturias2009",
    port = 5432
)


