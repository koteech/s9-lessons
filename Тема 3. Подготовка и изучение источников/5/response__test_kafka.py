import requests
import json

url = "https://order-gen-service.sprint9.tgcloudenv.ru/test_kafka"

data = {
    "student": "livingforsuccess",
    "kafka_connect": {
        "host": "rc1a-o2sosifhuilkhdgo.mdb.yandexcloud.net",
        "port": 9091,
        "topic": "order-service_orders",
        "producer_name": "producer_consumer",
        "producer_password": "producer_consumer"
    }
}

headers = {
    'Content-Type': 'application/json; charset=utf-8'
}

response = requests.post(url, headers=headers, data=json.dumps(data))

print(response.text)