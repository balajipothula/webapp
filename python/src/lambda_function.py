import os

from fastapi import FastAPI
from mangum import Mangum
from pydantic import BaseModel

app = FastAPI(title="WebApp")

class Login(BaseModel):
  id: str
  password: str

@app.get("/")
def index():
  return { "ping": "pong" }

@app.get("/wish")
def wish():
  return { "message": "Hello..!" }

lambda_handler = Mangum(app)
