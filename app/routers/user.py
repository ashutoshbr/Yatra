from fastapi import APIRouter, HTTPException, status, Response
from ..database import conn, cursor
from pydantic import BaseModel

router = APIRouter(prefix="/user", tags=["User"])


class User(BaseModel):
    email: str
    password: str


@router.get("/")
def get_user():
    cursor.execute(""" SELECT * FROM userinfo """)
    users = cursor.fetchall()
    return users