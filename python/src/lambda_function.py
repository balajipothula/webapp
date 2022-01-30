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
def index():
  return {"ping": "pong"}

@app.get("/health", name="Health", tags=["Health"])
def health():
  return { "message": "OK" }

lambda_handler = Mangum(app)
