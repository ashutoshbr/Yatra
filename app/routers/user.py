from typing import List

from fastapi import APIRouter, Depends, HTTPException, status
from fastapi.security.oauth2 import OAuth2PasswordRequestForm

from .. import oauth2, schemas, utils
from ..database import conn, cursor

router = APIRouter(prefix="/user", tags=["User"])


@router.get("/", response_model=List[schemas.User])
def get_users(user_email: str = Depends(oauth2.verify_access_token)):
    cursor.execute(""" SELECT * FROM userinfo """)
    users = cursor.fetchall()
    print(user_email)
    return users


@router.post("/", status_code=status.HTTP_201_CREATED)
def add_user(user: schemas.LoginUser):
    hashed_password = utils.hash(user.password)
    user.password = hashed_password
    try:
        cursor.execute(
            """ INSERT INTO userinfo (email, password) VALUES (%s, %s) RETURNING *""",
            (user.email, user.password),
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
def login_user(user_credentials: OAuth2PasswordRequestForm = Depends()):
    cursor.execute(
        """ SELECT password FROM userinfo WHERE email=%s """,
        (user_credentials.username,),
    )
    db_password = cursor.fetchone()

    if db_password == None or not (
        utils.verify(user_credentials.password, db_password["password"])
    ):
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN, detail="Invalid Credentials"
        )

    access_token = oauth2.create_access_token(data={"email": user_credentials.username})
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
