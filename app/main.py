from fastapi import FastAPI
from .routers import homestay, user

app = FastAPI()


@app.get("/")
def home():
    return {"message": "Namaste"}


app.include_router(homestay.router)
app.include_router(user.router)