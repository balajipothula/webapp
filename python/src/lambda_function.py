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
import datetime

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

from typing import List

import databases
import sqlalchemy

logging.getLogger("boto3").setLevel(logging.ERROR)
logging.getLogger("botocore").setLevel(logging.ERROR)

logger = logging.getLogger()
logger.setLevel(logging.ERROR)
#logger.setLevel(logging.INFO)


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
      service_name = "secretsmanager",
      region_name  = region
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
      logger.error("The request had invalid parameters.")
    elif exception == "InvalidRequestException":
      logger.error("The request was invalid.")
    elif exception == "ResourceNotFoundException":
      logger.error("The requested secret " + secret + " was not found")
  else:
    if "SecretString" in secretValue:
      return json.loads(secretValue["SecretString"])
    else:
      return json.loads(base64.b64decode(secretValue["SecretBinary"]))
  finally:
    pass


def getEngine(postgresql: dict):
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
      port       = postgresql["port"],
      database   = postgresql["database"],
      query      = None
    )
    engine = create_engine(
      url,
      echo         = eval(postgresql["echo"]),
      connect_args = { "connect_timeout": int(postgresql["connect_timeout"]) }
    )
    #connect = engine.connect()
    #return connect
    return engine
  except Exception as exception:
    exception_type, exception_value, exception_traceback = sys.exc_info()
    traceback_string = traceback.format_exception(exception_type, exception_value, exception_traceback)
    errorMessage = json.dumps({
      "errorType": exception_type.__name__,
      "errorMessage": str(exception_value),
      "stackTrace": traceback_string
    })
    logger.error(errorMessage)    

"""
region      = os.environ["region"]
secret     = os.environ["secret"]
postgresql = getCredentials(region = region, secret = secret)
url        = postgresql["dialect"] + "+" + postgresql["driver"] + "://" + postgresql["username"] + ":" + postgresql["password"] + "@" + postgresql["host"] + ":" + str(postgresql["port"]) + "/" + postgresql["database"]
database   = databases.Database(url)
engine     = getEngine(postgresql)
metadata   = sqlalchemy.MetaData()

metadata.create_all(engine)

song       = sqlalchemy.Table(
  "Song",
  metadata,
  sqlalchemy.Column("songId",     sqlalchemy.BigInteger, primary_key = True),
  sqlalchemy.Column("artist",     sqlalchemy.String),
  sqlalchemy.Column("title",      sqlalchemy.String),
  sqlalchemy.Column("difficulty", sqlalchemy.Float(precision = 2, asdecimal = True, decimal_return_scale = 2)),
  sqlalchemy.Column("level",      sqlalchemy.SmallInteger),
  sqlalchemy.Column("released",   sqlalchemy.String)
)

rating       = sqlalchemy.Table(
  "Rating",
  metadata,
  sqlalchemy.Column("id",   sqlalchemy.BigInteger),
  sqlalchemy.Column("rate", sqlalchemy.SmallInteger)
)

class Song(BaseModel):
  artist     : str
  title      : str
  difficulty : float
  level      : int
  released   : str

class Rating(BaseModel):
  id   : int
  rate : int
"""

app = FastAPI(
  title       = "WebApp",
  description = "Web Application using Python FastAPI",
  version     = "2022-02-07"
)

"""
@app.on_event("startup")
async def startup():
  await database.connect()

@app.on_event("shutdown")
async def shutdown():
  await database.disconnect()
"""

@app.get("/", name="Index", tags=["Index"])
def index(request: Request):
  return {"message": "Welcome to Python FastAPI WebApplication Service..."}

"""
@app.put("/song")
async def insertSong(song: Song):
  query  = "INSERT INTO webapp_db.public."Song"(artist, title, difficulty, level, released) VALUES (:artist, :title, :difficulty, :level, :released)"
  values = { "artist": song.artist, "title": song.title, "difficulty": song.difficulty, "level": song.level, "released": song.released }
  await database.execute(query = query, values = values)
  return {"message": "Hurray new song inserted :)"}

@app.get("/songs")
async def songs(page: int = -1):
  if page < 0: return await database.fetch_all(query = song.select())
  query  = "SELECT * FROM webapp_db.public."Song" ORDER BY "songId" LIMIT :limit OFFSET :offset"
  limit  = 4
  offset = limit * page
  values = { "limit": limit, "offset": offset }
  return await database.fetch_all(query = query, values = values)

@app.put("/song/rating")
async def insertRating(rating: Rating):
  if 5 < rating.rate or rating.rate < 1: return {"message": "Song rating must be in between 1 and 5 :("}
  query  = "INSERT INTO webapp_db.public."Rating"(id, rate) VALUES (:id, :rate)"
  values = { "id": rating.id, "rate": rating.rate }
  await database.execute(query = query, values = values)
  return {"message": "Your rating is taken into consideration :)"}

@app.get("/song/rating/{songId}")
async def getSongAvgMinMaxRating(songId: int):
  query  = "SELECT AVG("rate")::NUMERIC(10,2) AS "avgRating", MIN("rate") AS "minRating", MAX("rate") AS "maxRating" FROM webapp_db.public."Rating" WHERE "id" = :id"
  values = { "id": songId }
  return await database.fetch_one(query = query, values = values)

@app.get("/songs/search")
async def getSongsSearch(parameter: str):
  query  = "SELECT * FROM webapp_db.public."Song" WHERE artist ~* :artist OR title ~* :title"
  values = { "artist": parameter, "title": parameter }
  return await database.fetch_all(query = query, values = values)

@app.get("/songs/avg/difficulty")
async def getSongsAvgDifficulty(level: int = 0):
  query  = " SELECT AVG("difficulty")::NUMERIC(10,2) AS "avgDifficulty" FROM webapp_db.public."Song" "
  values = None
  if 0 < level:
    query  = "SELECT AVG("difficulty")::NUMERIC(10,2) AS "avgDifficulty" FROM webapp_db.public."Song" WHERE "level" = :level"
    values = { "level": level }
  return await database.fetch_all(query = query, values = values)
"""

lambda_handler = Mangum(app)
