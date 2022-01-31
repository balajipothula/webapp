from fastapi  import APIRouter
from fastapi  import FastAPI

from mangum   import Mangum
from pydantic import BaseModel

class Login(BaseModel):
  username: str
  password: str

app = FastAPI(
  title       = "WebApp",
  description = "Web Application using FastAPI.",
  version     = "1.0.0"
)

@app.get("/", name="Index", tags=["Index"])
def index() -> str:
  return {"ping": "pong"}

@app.post("/login")
def login(request: Request) :
  return  request.json()

lambda_handler = Mangum(app)
