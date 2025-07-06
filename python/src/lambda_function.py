from fastapi import FastAPI
from mangum import Mangum

app = FastAPI()

@app.get("/")
def root():
    return {"message": "Hello from Lambda"}

#  Mangum adapter must be named "handler" if handler = "lambda_function.handler"
handler = Mangum(app)
