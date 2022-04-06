from datetime import time

from pydantic import BaseModel, EmailStr


class Homestay(BaseModel):
    id: int
    name: str
    description: str
    created_at: time
    location: str
    price: float
    website: str | None
    image_url: str | None
    culture_type: str | None
    toilet_type: str | None
    bed_type: str | None
    cooling_soln: str | None
    house_type: str | None


class User(BaseModel):
    email: EmailStr
    password: str
