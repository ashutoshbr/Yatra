from fastapi import FastAPI
from pydantic import BaseModel
import psycopg2
from psycopg2.extras import RealDictCursor  # to show column names
import os
from dotenv import load_dotenv

load_dotenv()

app = FastAPI()


class Homestay(BaseModel):
    name: str
    description: str


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

@app.get("/homestay")
def get_homestay():
    homestays = cursor.execute(""" SELECT * FROM homestay""")
    return homestays

@app.get("/")
def home():
    return {"message": "Namaste"}
