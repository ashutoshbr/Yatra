from fastapi import FastAPI, HTTPException, status, Response
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
    cursor.execute(""" SELECT * FROM homestay """)
    homestays = cursor.fetchall()
    return homestays


@app.post("/homestay")
def add_homestay(homestay: Homestay):
    cursor.execute(
        """ INSERT INTO homestay (name, description) VALUES (%s, %s) RETURNING *""",
        (homestay.name, homestay.description),
    )
    conn.commit()
    new_homestay = cursor.fetchone()
    return new_homestay


@app.put("/homestay/{id}")
def update_homestay(id: int, homestay: Homestay):
    cursor.execute(
        """ UPDATE homestay SET name=%s, description=%s WHERE id=%s RETURNING *""",
        (homestay.name, homestay.description, str(id)),
    )
    updated_homestay = cursor.fetchone()
    conn.commit()
    if updated_homestay == None:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail=f"Post with {id} does not exist",
        )
    return updated_homestay


@app.delete("/homestay/{id}")
def delete_homestay(id: int):
    cursor.execute(
        """ DELETE FROM homestay WHERE id=%s RETURNING *""",
        (str(id)),
    )
    deleted_homestay = cursor.fetchone()
    conn.commit()
    if deleted_homestay == None:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail=f"Post with {id} does not exist",
        )
    return Response(status_code=status.HTTP_204_NO_CONTENT)


@app.get("/")
def home():
    return {"message": "Namaste"}
