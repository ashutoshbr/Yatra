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
    owner_name: str | None
    owner_phone: str | None
    owner_email: str | None
    image1: str | None
    image2: str | None
    image3: str | None
    latitude: str | None
    longitude: str | None


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
    owner_name: str | None
    owner_phone: str | None
    owner_email: str | None
    image1: str | None
    image2: str | None
    image3: str | None
    latitude: float | None
    longitude: float | None


class User(BaseModel):
    id: int
    email: str
    country: str | None
    fullname: str
    username: str


class AddUser(BaseModel):
    email: str
    password: str
    country: str | None
    phone: str | None
    dob: date | None
    fname: str | None
    lname: str | None


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


class AddBooking(BaseModel):
    date: str | None
    no_of_days: int
    homestay_id: int
    no_of_rooms: int