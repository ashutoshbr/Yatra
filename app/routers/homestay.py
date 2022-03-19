from fastapi import APIRouter, HTTPException, status, Response
from ..database import conn, cursor
from pydantic import BaseModel

router = APIRouter(prefix="/homestay", tags=["Homestay"])


class Homestay(BaseModel):
    name: str
    description: str


@router.get("/")
def get_homestay():
    cursor.execute(""" SELECT * FROM homestay """)
    homestays = cursor.fetchall()
    return homestays


@router.post("/")
def add_homestay(homestay: Homestay):
    cursor.execute(
        """ INSERT INTO homestay (name, description) VALUES (%s, %s) RETURNING *""",
        (homestay.name, homestay.description),
    )
    conn.commit()
    new_homestay = cursor.fetchone()
    return new_homestay


@router.put("/{id}")
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


@router.delete("/{id}")
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
