from fastapi import FastAPI
from mangum import Mangum
import logging

logger = logging.getLogger()
logger.setLevel(logging.INFO)


app = FastAPI()

@app.get("/")
def root():
    logger.info("GET / hit")
    return {"message": "Hello from FastAPI on Lambda!"}

# Required for AWS Lambda to trigger FastAPI
handler = Mangum(app)
