from typing import List

from fastapi import APIRouter, Depends, HTTPException, Response, status

from .. import oauth2, schemas
from ..database import conn, cursor

router = APIRouter(prefix="/homestay", tags=["Homestay"])


@router.get("/", response_model=List[schemas.GetHomestay])
def get_homestay():
    cursor.execute(""" SELECT * FROM homestay """)
    homestays = cursor.fetchall()
    return homestays


@router.post("/")
def add_homestay(
    homestay: schemas.PostHomestay,
    user_email: str = Depends(oauth2.verify_access_token),
):
    cursor.execute(
        """ INSERT INTO homestay (name, description, location, price, website, image_url, culture_type, toilet_type, bed_type, cooling_soln, house_type, no_of_available_rooms, near_dest, owner_name, owner_phone, owner_email, image1, image2, image3, latitude, longitude) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s) RETURNING *""",
        (
            homestay.name,
            homestay.description,
            homestay.location,
            homestay.price,
            homestay.website,
            homestay.image_url,
            homestay.culture_type,
            homestay.toilet_type,
            homestay.bed_type,
            homestay.cooling_soln,
            homestay.house_type,
            homestay.no_of_available_rooms,
            homestay.near_dest,
            homestay.owner_name,
            homestay.owner_phone,
            homestay.owner_email,
            homestay.image1,
            homestay.image2,
            homestay.image3,
            homestay.latitude,
            homestay.longitude,
        ),
    )
    conn.commit()
    new_homestay = cursor.fetchone()
    print(user_email)
    return new_homestay


@router.put("/{id}")
def update_homestay(
    id: int,
    homestay: schemas.PostHomestay,
    user_email: str = Depends(oauth2.verify_access_token),
):
    cursor.execute(
        """ UPDATE homestay SET name=%s, description=%s, location=%s, price=%s, website=%s, image_url=%s, culture_type=%s, toilet_type=%s, bed_type=%s, cooling_soln=%s, house_type=%s WHERE id=%s RETURNING *""",
        (
            homestay.name,
            homestay.description,
            homestay.location,
            homestay.price,
            homestay.website,
            homestay.image_url,
            homestay.culture_type,
            homestay.toilet_type,
            homestay.bed_type,
            homestay.cooling_soln,
            homestay.house_type,
            str(id),
        ),
    )
    updated_homestay = cursor.fetchone()
    conn.commit()
    if updated_homestay == None:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail=f"Post with {id} does not exist",
        )
    print(user_email)
    return updated_homestay


@router.delete("/{id}")
def delete_homestay(id: int, user_email: str = Depends(oauth2.verify_access_token)):
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
    print(user_email)
    return Response(status_code=status.HTTP_204_NO_CONTENT)
