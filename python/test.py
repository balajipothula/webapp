from fastapi.testclient import TestClient
from lambda_function import app
#from main import app

client = TestClient(app)

def test_index():
  response = client.get("/")
  assert response.status_code == 200

def test_health():
  response = client.get("/health")
  assert response.status_code == 200
