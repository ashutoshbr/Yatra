from fastapi import APIRouter, HTTPException, status, Depends
from ..database import cursor, conn
from .. import schemas, utils, oauth2


router = APIRouter(prefix="/user", tags=["User"])


@router.get("/")
def get_user():
    cursor.execute(""" SELECT * FROM userinfo """)
    users = cursor.fetchall()
    return users


@router.post("/", status_code=status.HTTP_201_CREATED)
def add_user(user: schemas.User):
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
def login_user(user: schemas.User):
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
