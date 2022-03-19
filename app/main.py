from fastapi import FastAPI
from .routers import homestay

app = FastAPI()


@app.get("/")
def home():
    return {"message": "Namaste"}


app.include_router(homestay.router)
