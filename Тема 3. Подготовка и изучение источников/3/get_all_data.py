import redis

def main():
    # указываем параметры, которые необходимы для подключения
    host = 'rc1d-fffi8dh4mlg9qpj0.mdb.yandexcloud.net'
    port = '6380'
    password = 'redis345'
    ca_path = r'C:\Users\koteech\.redis\YandexInternalRootCA.crt'

    # инициализируем клиент, с помощью которого будем подключаться к Redis
    client = redis.StrictRedis(
        host=host,
        port=port,
        password=password,
        ssl=True,
        ssl_ca_certs=ca_path)

    keys = client.keys('*')
    for key in keys:
        key_str = key.decode('utf-8')  # Ключи в Redis хранятся как байты, декодируем в строку
        value = client.get(key_str).decode('utf-8')  # Получаем значение для ключа и декодируем в строку
        print(f"Key: {key_str}, Value: {value}")

if __name__ == '__main__':
    main()
