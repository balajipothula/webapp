from fastapi import FastAPI
from mangum import Mangum

app = FastAPI()

@app.get("/")
def root():
    return {"message": "Hello from FastAPI on Lambda!"}

# Required for AWS Lambda to trigger FastAPI
handler = Mangum(app)
