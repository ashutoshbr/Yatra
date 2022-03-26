from fastapi import APIRouter, HTTPException, status, Response
from ..database import cursor, conn
from .. import schemas, utils


router = APIRouter(prefix="/user", tags=["User"])


@router.get("/")
def get_user():
    cursor.execute(""" SELECT * FROM userinfo """)
    users = cursor.fetchall()
    return users

@router.post("/")
def add_homestay(user: schemas.User):
    hashed_password = utils.hash(user.password)
    user.password = hashed_password
    cursor.execute(
        """ INSERT INTO userinfo (email, password) VALUES (%s, %s) RETURNING *""",
        (user.email, user.password)
    )
    conn.commit()
    new_user = cursor.fetchone()
    return new_user