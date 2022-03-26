from pydantic import BaseModel


class Homestay(BaseModel):
    name: str
    description: str


class User(BaseModel):
    email: str
    password: str
