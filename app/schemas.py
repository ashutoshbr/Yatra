from pydantic import BaseModel, EmailStr


class Homestay(BaseModel):
    name: str
    description: str


class User(BaseModel):
    email: EmailStr
    password: str
