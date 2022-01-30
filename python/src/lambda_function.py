import os

from fastapi  import APIRouter
from fastapi  import FastAPI

from mangum   import Mangum
from pydantic import BaseModel

class Login(BaseModel):
  id: str
  password: str

app = FastAPI(
  title       = "WebApp",
  description = "Web Application using FastAPI.",
  version     = "1.0.0"
)

@app.get("/", name="Index", tags=["Index"])
def index() -> str:
  return {"ping": "pong"}

@app.get("/health", name="Health", tags=["Health"])
def health() -> str:
  return {"message": "OK"}

@app.post("/login/")
def login(username: str, password: str) -> str:
  return {"Username": username}

lambda_handler = Mangum(app)
