import redis
import json

def get_category_by_dish_name(restaurant_id, dish_name):
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

    # получим значение ключа с помощью команды get
    result = client.get(restaurant_id)

    if not result:
        print(f"Запись с указанным ключом '{restaurant_id}' не найдена.")
        return

    result_json = result.decode("utf-8")
    print (result_json)
    try:
        result_dict = json.loads(result_json)
        menu = result_dict.get("menu", [])

        for dish in menu:
            if dish.get("name") == dish_name:
                category = dish.get("category")
                if category is not None:
                    print(f"Блюдо '{dish_name}' из категории '{category}' в ресторане с id '{restaurant_id}'.")
                    return
                else:
                    print(f"Категория для блюда '{dish_name}' в ресторане с id '{restaurant_id}' не найдена.")
                    return
        
        print(f"Блюдо '{dish_name}' не найдено в ресторане с id '{restaurant_id}'.")
    except json.JSONDecodeError:
        print("Ошибка декодирования JSON данных.")

if __name__ == '__main__':
    # Задайте нужные значения для restaurant_id и dish_name
    restaurant_id = "ef8c42c19b7518a9aebec106"
    dish_name = "Панир Тикка"
    
    get_category_by_dish_name(restaurant_id, dish_name)
