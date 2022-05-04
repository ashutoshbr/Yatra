from typing import List

from fastapi import APIRouter, Depends, HTTPException, status

from .. import oauth2, schemas, utils
from ..database import conn, cursor

router = APIRouter(prefix="/user", tags=["User"])


@router.get("/", response_model=List[schemas.User])
def get_users():
    cursor.execute(""" SELECT * FROM userinfo """)
    users = cursor.fetchall()
    return users


@router.post("/", status_code=status.HTTP_201_CREATED)
def add_user(user: schemas.AddUser):
    hashed_password = utils.hash(user.password)
    user.password = hashed_password
    try:
        cursor.execute(
            """ INSERT INTO userinfo (email, password, country, username, fullname) VALUES (%s, %s,%s, %s, %s) RETURNING *""",
            (user.email, user.password, user.country, user.username, user.fullname),
        )
        conn.commit()
        return "Success"
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

    cursor.execute(
        """ SELECT id FROM userinfo WHERE email= %s """,
        (user_credentials.email,),
    )
    user_id = cursor.fetchone()
    access_token = oauth2.create_access_token(data={"id": user_id["id"]})
    return {"access_token": access_token, "token_type": "bearer"}


@router.get("/favourite")
def get_favourite(user_id: int = Depends(oauth2.verify_access_token)):
    print(user_id)
    cursor.execute(
        """ SELECT * FROM homestay INNER JOIN favourite ON homestay.id=favourite.homestay_id WHERE user_id=%s""",
        (str(user_id),),
    )
    favourites = cursor.fetchall()
    return favourites


@router.post("/favourite")
def add_favourite(
    favourite: schemas.AddFavourite,
    user_id: str = Depends(oauth2.verify_access_token),
):
    print(user_id, favourite.homestay_id)
    try:
        cursor.execute(
            """ INSERT INTO favourite (user_id, homestay_id) VALUES (%s, %s) RETURNING *""",
            (user_id, favourite.homestay_id),
        )
        cursor.fetchone()
        conn.commit()
    except:
        cursor.execute("""ROLLBACK;""")
        conn.commit()
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail=f"Invalid action",
        )
    return "Success"
