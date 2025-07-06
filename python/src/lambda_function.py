from fastapi import FastAPI
from mangum import Mangum

app = FastAPI()

@app.get("/")
def root():
    return {"message": "Hello from Lambda"}

#  Create Mangum adapter correctly
handler = Mangum(app)
