import boto3
import json
import logging
import os
import psycopg
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
logger.setLevel(logging.INFO)



def lambda_handler(event, context):
    secret_name = "webapp-db-credentials-1"
    region_name = "eu-central-1"

    session = boto3.session.Session()
    client = session.client(
        service_name='secretsmanager',
        region_name=region_name
    )

    try:
        get_secret_value_response = client.get_secret_value(
            SecretId=secret_name
        )
    except ClientError as e:
        raise e

    secret = get_secret_value_response['SecretString']
    return {
        'statusCode': 200,
        'body': secret
    }
