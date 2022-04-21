from typing import List

from fastapi import APIRouter, Depends, HTTPException, status
from fastapi.security.oauth2 import OAuth2PasswordRequestForm

from .. import oauth2, schemas, utils
from ..schemas import SignupUser
from ..database import conn, cursor
import json

router = APIRouter(prefix="/user", tags=["User"])


@router.get("/", response_model=List[schemas.User])
def get_users():
    print("hell")
    cursor.execute(""" SELECT * FROM userinfo """)
    users = cursor.fetchall()
    # print(user_email)
    return users


@router.post("/")
def add_user(jsonUser):
    print("hell")
    j = json.loads(jsonUser)
    email = j["email"]
    password = j["password"]
    country = j["country"]
    fullname = j["fullname"]
    username = j["username"]
    print(username)
    user1 = SignupUser(email, password, country, fullname, username)
    hashed_password = utils.hash(user1.password)
    user1.password = hashed_password
    try:
        cursor.execute(
            """ INSERT INTO userinfo (email, password, country, full_name, username) VALUES (%s, %s, %s, %s, %s) RETURNING *""",
            (user1.email, user1.password, user1.country, user1.full_name , user1.username),
        )
        conn.commit()
        new_user = cursor.fetchone()
        return new_user
    except:
        cursor.execute("""ROLLBACK;""")
        conn.commit()
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail=f"Email already exists",
        )


@router.post("/login", response_model=schemas.Token)
def login_user(user_credentials: schemas.LoginUser):
    cursor.execute(
        """ SELECT password FROM userinfo WHERE email= %s """,
        (user_credentials.email,),
    )
    db_password = cursor.fetchone()

    if db_password == None or not (
        utils.verify(user_credentials.password, db_password["password"])
    ):
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN, detail="Invalid Credentials"
        )

    access_token = oauth2.create_access_token(data={"email": user_credentials.email})
    return {"access_token": access_token, "token_type": "bearer"}


@router.get("/favourite")
def get_favourite(user_email: str = Depends(oauth2.verify_access_token)):
    cursor.execute(""" SELECT homestay_id FROM favourite """)
    favourites = cursor.fetchall()
    print(user_email)
    return favourites


@router.post("/favourite")
def add_favourite(
    favourite: schemas.AddFavourite,
    user_email: str = Depends(oauth2.verify_access_token),
):
    try:
        cursor.execute(""" SELECT id FROM userinfo WHERE email=%s""", (user_email,)),
        user_id = cursor.fetchone()
        cursor.execute(
            """ INSERT INTO favourite (user_id, homestay_id) VALUES (%s, %s) RETURNING *""",
            (user_id["id"], favourite.homestay_id),
        )
        new_favourite = cursor.fetchone()
        conn.commit()
        print(user_email, user_id["id"])
    except:
        cursor.execute("""ROLLBACK;""")
        conn.commit()
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail=f"Invalid action",
        )
    return new_favourite
