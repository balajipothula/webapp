import os

from fastapi import FastAPI
from mangum import Mangum

stage = os.environ.get('STAGE', None)
openapi_prefix = f"/{stage}" if stage else "/"

#app = FastAPI(title="WebApp")
app = FastAPI(title = "WebApp", openapi_prefix=openapi_prefix)

@app.get("/")
def index():
  return {"ping": "pong"}

lambda_handler = Mangum(app)
