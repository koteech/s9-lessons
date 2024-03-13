import redis
import json

def get_user_login(user_id, client):
    # получим значение ключа (id пользователя) с помощью команды get
    result = client.get(user_id)

    if not result:
        return None  # Если запись с указанным ключом не найдена

    try:
        result_dict = json.loads(result.decode("utf-8"))
        login_value = result_dict.get("login")
        return login_value
    except json.JSONDecodeError:
        return None  # Если произошла ошибка декодирования JSON данных

def main():
    # указываем параметры, которые необходимы для подключения
    host = 'rc1d-fffi8dh4mlg9qpj0.mdb.yandexcloud.net'
    port = '6380'
    password = 'redis345'
    ca_path = r'C:\Users\koteech\.redis\YandexInternalRootCA.crt'
    user_id = "626a81ce9a8cd1920641e264"

    # инициализируем клиент, с помощью которого будем подключаться к Redis
    client = redis.StrictRedis(
        host=host,
        port=port,
        password=password,
        ssl=True,
        ssl_ca_certs=ca_path)

    # получим значение поля "login" с ключом (id пользователя) "626a81ce9a8cd1920641e264"
    login_value = get_user_login(user_id, client)

    if login_value is not None:
        print(f"Значение поля 'login' для пользователя с id '{user_id}': {login_value}")
    else:
        print(f"Запись с указанным id пользователя не найдена или произошла ошибка декодирования JSON данных.")

if __name__ == '__main__':
    main()
