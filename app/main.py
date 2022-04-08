from fastapi import FastAPI

from .routers import homestay, search, user

app = FastAPI()


@app.get("/")
def home():
    return {"message": "Namaste"}


app.include_router(homestay.router)
app.include_router(user.router)
app.include_router(search.router)
