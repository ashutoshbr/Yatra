from fastapi import APIRouter, HTTPException, status, Response
from ..database import cursor

router = APIRouter(prefix="/user", tags=["User"])


@router.get("/")
def get_user():
    cursor.execute(""" SELECT * FROM userinfo """)
    users = cursor.fetchall()
    return users
