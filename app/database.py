import psycopg2
from psycopg2.extras import RealDictCursor  # to show column names
import os
from dotenv import load_dotenv

load_dotenv()

try:
    conn = psycopg2.connect(
        host="homestay.postgres.database.azure.com",
        database="homestaydb",
        user=f"{os.environ['USER']}",
        password=f"{os.environ['PASSWORD']}",
        cursor_factory=RealDictCursor,
    )
    cursor = conn.cursor()
    print("DB connections SUCCESS")
except Exception as error:
    print("Connection to DB Failed")
    print("ERROR!!!", error)
