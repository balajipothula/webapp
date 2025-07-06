from fastapi import FastAPI
from mangum import Mangum

app = FastAPI()

@app.get("/")
def root():
    return {"message": "Hello from Lambda"}

# Create a Mangum adapter
adapter = Mangum(app)

def lambda_handler(event, context):
    return adapter(event, context)
