import logging
from fastapi import FastAPI
from mangum import Mangum

logger = logging.getLogger()
logger.setLevel(logging.INFO)

app = FastAPI()

@app.get("/")
def root():
    logger.info("Root endpoint hit.")
    return {"message": "Hello from Lambda"}

adapter = Mangum(app)

def lambda_handler(event, context):
    logger.info(f"Event received: {event}")
    return adapter(event, context)
