from datetime import date, time

from pydantic import BaseModel, EmailStr


class GetHomestay(BaseModel):
    id: int
    name: str
    description: str
    created_at: time
    location: str
    price: int
    website: str | None
    image_url: str | None
    culture_type: str | None
    toilet_type: str | None
    bed_type: str | None
    cooling_soln: str | None
    house_type: str | None
    no_of_available_rooms: int | None
    near_dest: str | None


class PostHomestay(BaseModel):
    name: str
    description: str
    location: str
    price: float
    website: str | None
    image_url: str | None
    culture_type: str | None
    toilet_type: str | None
    bed_type: str | None
    cooling_soln: str | None
    house_type: str | None
    no_of_available_rooms: int | None
    near_dest: str | None


class User(BaseModel):
    id: int
    email: str
    country: str | None
    full_name: str
    username: str


class LoginUser(BaseModel):
    email: EmailStr
    password: str


class AddUser(BaseModel):
    email: str
    password: str
    country: str | None
    username: str
    fullname: str


class Token(BaseModel):
    access_token: str
    token_type: str


class AddFavourite(BaseModel):
    homestay_id: int
