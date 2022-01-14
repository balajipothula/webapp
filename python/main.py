import os

from fastapi import FastAPI
from mangum import Mangum

stage = os.environ.get("STAGE", None)

openapi_prefix = f"/{stage}" if stage else "/"

app = FastAPI(title="WebApp", openapi_prefix=openapi_prefix)

@app.get("/")
def index() -> str:
  """
  Get Index Page message from the Web Application.
  """
  return {"message": "hi"}

@app.get("/health")
def health() -> str:
  """
  Get Health Status of the Web Application.
  Funcation Name: health
  Parameters:
    None : None
  Returns:
    health : str
    Health Status of the Web Application.
  """ 
  return {"health": "ok"}

@app.get("/user/{name}")
def user(name: str) -> str:
  return {"name": name}

handler = Mangum(app = app)
