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

    # просто подключиться недостаточно, да и неинтересно: нужно же ещё и поработать с хранилищем

    # запишем в Redis ключ here_is_the_key и соответствующее ему строковое значение string value
    #client.set("here_is_the_key", "string value")

    # получим значение ключа с помощью команды get
    result = client.get("a51e4e31ae4602047ec52534")
    if not result:
        print("Запись с указанным ключом не найдена.")
        return

    result = result.decode("utf-8")
    print(result)

if __name__ == '__main__':
    main()
