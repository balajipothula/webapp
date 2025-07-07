from fastapi import FastAPI
from mangum import Mangum
import logging

logger = logging.getLogger()
logger.setLevel(logging.INFO)

app = FastAPI()

@app.get("/")
def root():
    logger.info("Lambda hit the root endpoint")
    return {"message": "Hello from FastAPI on Lambda!"}

handler = Mangum(app)
