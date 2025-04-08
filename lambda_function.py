import boto3
import uuid
import os
from datetime import datetime, timedelta

def lambda_handler(event, context):
    # Initialize AWS clients
    ce = boto3.client('ce')
    dynamodb = boto3.resource('dynamodb')
    table = dynamodb.Table(os.environ['DYNAMODB_TABLE'])

    # Define forecast time window
    today = datetime.today()
    end_date = today + timedelta(days=7)

    # Get forecast from Cost Explorer
    response = ce.get_cost_forecast(
        TimePeriod={
            'Start': today.strftime('%Y-%m-%d'),
            'End': end_date.strftime('%Y-%m-%d')
        },
        Metric='UNBLENDED_COST',
        Granularity='DAILY'
    )

    forecast = response['ForecastResultsByTime']

    # Store each forecasted day in DynamoDB
    for day in forecast:
        item = {
            'id': str(uuid.uuid4()),
            'timestamp': str(datetime.utcnow()),
            'start': day['TimePeriod']['Start'],
            'end': day['TimePeriod']['End'],
            'forecast_amount': day['MeanValue']
        }

        table.put_item(Item=item)

    return {
        'statusCode': 200,
        'body': 'Forecast stored in DynamoDB.'
    }
