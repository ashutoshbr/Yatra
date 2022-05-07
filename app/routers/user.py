import os
from typing import List

import yagmail
from dotenv import load_dotenv
from fastapi import APIRouter, Depends, HTTPException, status

from .. import oauth2, schemas, utils
from ..database import conn, cursor

load_dotenv()
router = APIRouter(prefix="/user", tags=["User"])


@router.get("/", response_model=List[schemas.User])
def get_users():
    cursor.execute(""" SELECT * FROM userinfo """)
    users = cursor.fetchall()
    return users

@router.get("/profile")
def get_profile(user_id: int = Depends(oauth2.verify_access_token)):
    cursor.execute(
        """ SELECT email, username FROM userinfo WHERE user_id=%s""",
        (str(user_id),),
    )
    user = cursor.fetchone()
    return user



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


@router.get("/favourite", response_model=List[schemas.GetHomestay])
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
    try:
        cursor.execute(
            """ INSERT INTO favourite (user_id, homestay_id) VALUES (%s, %s) RETURNING *""",
            (user_id, favourite.homestay_id),
        )
        conn.commit()
    except:
        cursor.execute("""ROLLBACK;""")
        conn.commit()
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail=f"Invalid action",
        )
    return "Added to favourite"


@router.post("/booking")
def add_booking(
    booking: schemas.AddBooking,
    user_id: str = Depends(oauth2.verify_access_token),
):
    try:
        cursor.execute(
            """ INSERT INTO booking (user_id, date, no_of_days, homestay_id, no_of_customers) VALUES (%s, %s, %s, %s, %s) RETURNING *""",
            (
                user_id,
                booking.date,
                booking.no_of_days,
                booking.homestay_id,
                booking.no_of_customers,
            ),
        )
        conn.commit()
    except:
        cursor.execute("""ROLLBACK;""")
        conn.commit()
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail=f"Invalid action",
        )

    cursor.execute(
        """ SELECT owner_email FROM homestay WHERE id=%s""",
        (booking.homestay_id,),
    )
    owner_email = cursor.fetchone()["owner_email"]
    print(owner_email)
    yag = yagmail.SMTP(f"{os.environ['GUSER']}", f"{os.environ['GPASS']}")
    yag.send(
        f"{owner_email}",
        subject="Homestay Booked",
        contents=f"Your homestay has been booked.\n\nDetails:\nUser ID: {user_id}\nDate:{booking.date}\nNo of. Days: {booking.no_of_days}\nNo. of customers: {booking.no_of_customers}",
    )

    return "Homestay booked"
