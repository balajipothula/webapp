import os
import sys
import logging
import traceback
import json

logger = logging.getLogger()
logger.setLevel(logging.INFO)

def lambda_handler(event, context):
  try:
    dialect = os.environ["dialect"]
    logger.info(f"dialect: {dialect}")
    return {
      "statusCode": 200,
      "body": json.dumps("WebApp")
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
