import logging
from fastapi import FastAPI
from mangum import Mangum

logger = logging.getLogger()
logger.setLevel(logging.INFO)

if not logger.handlers:
    handler = logging.StreamHandler()
    formatter = logging.Formatter("%(asctime)s [%(levelname)s] %(message)s")
    handler.setFormatter(formatter)
    logger.addHandler(handler)


app = FastAPI()

@app.get("/")
def root():
    logger.info("Lambda hit the root endpoint")
    return {"message": "Hello from FastAPI on Lambda!"}


handler = Mangum(app)
