import requests
import json

url = "https://redis-data-service.sprint9.tgcloudenv.ru/test_redis"
headers = {'Content-Type': 'application/json; charset=utf-8'}

data = {
    "redis": {
        "host": "rc1d-fffi8dh4mlg9qpj0.mdb.yandexcloud.net",
        "port": 6380,
        "password": "redis345"
    }
}

response = requests.post(url, headers=headers, json=data)

print(response.status_code)
print(response.text)
