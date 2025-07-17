import boto3
from botocore.exceptions import ClientError

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
