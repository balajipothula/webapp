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


logging.getLogger("boto3").setLevel(logging.WARNING)
logging.getLogger("botocore").setLevel(logging.WARNING)

logger = logging.getLogger()
logger.setLevel(logging.INFO)


def getCredentialDict(region: str, secret: str) -> dict:
  """
  Get PostgreSQL Server credentials from Secrets Manager 
  by providing region and secret name.
  Parameters:
    region : str
    AWS Region name.
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


def lambda_handler(event, context):

  try:
  
    postgresql = getCredentialDict(region = "eu-central-1", secret = "webapp")

    url = URL(
      drivername = "postgresql" + "+" + "psycopg2",
      username   = postgresql["username"],
      password   = postgresql["password"],
      host       = postgresql["host"],
      database   = postgresql["database"],
      query      = None
    )
    
    engine = create_engine(
      url,
      echo = False,
      connect_args = { "connect_timeout": 30 }
    )

    connect = engine.connect()
    
    statement = text("""SELECT version()""")
    
    rows = connect.execute(statement)

    version = rows.fetchone()

    return {
      "statusCode": 200,
      "body": json.dumps(version)
    }

  except Exception as exception:
    exception_type, exception_value, exception_traceback = sys.exc_info()
    traceback_string = traceback.format_exception(exception_type, exception_value, exception_traceback)
    errorMessage = json.dumps({
      "errorType": exception_type.__name__,
      "errorMessage": str(exception_value),
      "stackTrace": traceback_string
    })
    logger.error(errorMessage)
