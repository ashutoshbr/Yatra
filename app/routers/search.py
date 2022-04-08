from typing import List

from fastapi import APIRouter

from .. import schemas
from ..database import conn, cursor

router = APIRouter(prefix="/search", tags=["Search"])


@router.get("/", response_model=List[schemas.GetHomestay])
def get_req_homestay(name: str | None = None, location: str | None = None):
    cursor.execute(
        """ SELECT * FROM homestay WHERE LOWER(name) LIKE LOWER(%s) OR LOWER(location) LIKE(%s)""",
        (name, location),
    )
    homestays = cursor.fetchall()
    return homestays
