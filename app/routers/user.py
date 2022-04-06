from typing import List

from fastapi import APIRouter, Depends, HTTPException, status

from .. import oauth2, schemas, utils
from ..database import conn, cursor

router = APIRouter(prefix="/user", tags=["User"])


@router.get("/", response_model=List[schemas.User])
def get_user():
    cursor.execute(""" SELECT * FROM userinfo """)
    users = cursor.fetchall()
    return users


@router.post("/", status_code=status.HTTP_201_CREATED)
def add_user(user: schemas.LoginUser):
    hashed_password = utils.hash(user.password)
    user.password = hashed_password
    cursor.execute(
        """ INSERT INTO userinfo (email, password) VALUES (%s, %s) RETURNING *""",
        (user.email, user.password),
    )
    conn.commit()
    new_user = cursor.fetchone()
    return new_user


@router.post("/login")
def login_user(user: schemas.LoginUser):
    cursor.execute(
        """ SELECT password FROM userinfo WHERE email=%s """,
        (user.email,),
    )
    db_password = cursor.fetchone()

    if db_password == None or not (
        utils.verify(user.password, db_password["password"])
    ):
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN, detail="Invalid Credentials"
        )

    access_token = oauth2.create_access_token(data={"email": user.email})
    return {"access_token": access_token, "token_type": "bearer"}
