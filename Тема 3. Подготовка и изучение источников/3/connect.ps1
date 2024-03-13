curl -Uri "https://redis-data-service.sprint9.tgcloudenv.ru/test_redis" -Method Post -Headers @{'Content-Type' = 'application/json; charset=utf-8'} -InFile - << EOF
{
    "redis":{
        "host": "rc1d-fffi8dh4mlg9qpj0.mdb.yandexcloud.net",
        "port": 6380,
        "password": "koteech1"
    }
}
EOF
