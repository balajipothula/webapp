import boto3
import json
import logging
import os
import psycopg2
import sys
import traceback
import base64
import gzip
import os

from botocore.exceptions import ClientError

from json.decoder import JSONDecodeError

from sqlalchemy import create_engine
from sqlalchemy import engine
from sqlalchemy import text

from sqlalchemy.engine.interfaces import Dialect
from sqlalchemy.engine.url import URL
from sqlalchemy.exc import SQLAlchemyError
from sqlalchemy.orm import session
from sqlalchemy.orm import sessionmaker

from sqlalchemy import insert

from fastapi import FastAPI
from fastapi import Request

from mangum  import Mangum

from pydantic import BaseModel


logging.getLogger("boto3").setLevel(logging.WARNING)
logging.getLogger("botocore").setLevel(logging.WARNING)

logger = logging.getLogger()
logger.setLevel(logging.INFO)


def getCredentials(region: str, secret: str) -> dict:
  """
  Get PostgreSQL Server credentials from Secrets Manager,
  by providing region and secret name.
  Parameters:
    region : str
    AWS Region Name.
    secret : str
    AWS Secrets Manager secret name.
  Returns:
    credentialDict : dict
    PostgreSQL Server credentials.
  """
  try:
    # Creating Secrets Manager Client.
    session = boto3.session.Session()
    client = session.client(
      service_name="secretsmanager",
      region_name=region
    )
    secretValue = client.get_secret_value(SecretId=secret)
  except ClientError as clientError:
    logger.setLevel(logging.ERROR)
    exception = clientError.response["Error"]["Code"]
    if exception == "DecryptionFailureException":
      logger.error("Secrets Manager can not decrypt the provided KMS key")
    elif exception == "InternalServiceErrorException":
      logger.error("An error occurred on the server side.")
    elif exception == "InvalidParameterException":
      logger.error("The request had invalid parameters: ", str(clientError))
    elif exception == "InvalidRequestException":
      logger.error("The request was invalid due to :", str(clientError))
    elif exception == "ResourceNotFoundException":
      logger.error("The requested secret " + secret + " was not found")
  else:
    if "SecretString" in secretValue:
      return json.loads(secretValue["SecretString"])
    else:
      return json.loads(base64.b64decode(secretValue["SecretBinary"]))
  finally:
    pass


def getConnect(postgresql: dict):
  """
  Get PostgreSQL Database Server connection,
  by providing credentials.
  Parameters:
    postgresql : dict
    PostgreSQL credentials.
  Returns:
    connect : 
    PostgreSQL Database Server connection.
  """
  try:
    url = URL(
      drivername = postgresql["dialect"] + "+" + postgresql["driver"],
      username   = postgresql["username"],
      password   = postgresql["password"],
      host       = postgresql["host"],
      database   = postgresql["database"],
      query      = None
    )
    engine = create_engine(
      url,
      echo         = eval(postgresql["echo"]),
      connect_args = { "connect_timeout": int(postgresql["connect_timeout"]) }
    )
    connect = engine.connect()
    return connect
  except Exception as exception:
    exception_type, exception_value, exception_traceback = sys.exc_info()
    traceback_string = traceback.format_exception(exception_type, exception_value, exception_traceback)
    errorMessage = json.dumps({
      "errorType": exception_type.__name__,
      "errorMessage": str(exception_value),
      "stackTrace": traceback_string
    })
    logger.error(errorMessage)    

postgresql = getCredentials(region = "eu-central-1", secret = "webapp")
connect    = getConnect(postgresql)

class Login(BaseModel):
  username: str
  password: str

app = FastAPI(
  title       = "WebApp",
  description = "Web Application using FastAPI.",
  version     = "1.0.0"
)

@app.get("/", name="Index", tags=["Index"])
def index(request: Request):
  clientHost = request.client.host
  return {"clientHost": clientHost}

@app.put("/register", name="Register", tags=["Register"])
def register(login: Login):
  sql = """
    INSERT INTO webapp_db.public."Login"(
      "username",
      "password"
    )
    VALUES(
      %s,
      %s
    )
  """
  flag = connect.execute(sql, login.username, login.password)
  return {"message": "User registered successfully :)" }

@app.post("/login", name="Login", tags=["Login"])
def login(login: Login):
  sql = """
    SELECT
      "password"
    FROM
      webapp_db.public."Login"
    WHERE
      username = %s
  """
  rows = connect.execute(sql, login.username)
  password = rows.first()[0]
  if login.password.__eq__(password):
    return {"message": "Login successful :)"}
  return {"message": "Login failed :("}


lambda_handler = Mangum(app)
