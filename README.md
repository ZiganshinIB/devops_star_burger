# Проект Star Burger 
Предназначен для сборки проекта в Docker и Kubernetes
## Требовании 
Программы необходимые для сборки:
- Docker (желательно Docker version 27.2.1, build 9e34c9b)
- kubectl (желательно версия 1.31.0)
- minikube (желательно версия 1.34.0)
## Быстрый старт

### Клонируйте проект на свой локальный компьютер 
```shell
git clone ...
cd docker_star_burger
```
### Создайте файл с переменными окружения `.env` в корневой каталог проекта
```bash
SECRET_KEY=django-insecure-0if40nf4nf93n4
YANDEX_API_KEY=610526f4-26ba-44c5-a498-a82f22d28d35
PG_USER=db_user
PG_PASSWORD=secret_password
PG_DB=db_name

```
- `SECRET_KEY` — секретный ключ проекта. Он отвечает за шифрование на сайте. Например, им зашифрованы все пароли на вашем сайте.
- `YANDEX_API_KEY` — Получить токен  YANDEX_API_KEY можно получить по следующей ссылке https://developer.tech.yandex.ru/services/3
- `PG_USER` — имя пользователя базы данных (Опционально)
- `PG_PASSWORD` — пароль пользователя базы данных (Опционально)
- `PG_DB` — название базы данных (Опционально)
### Запустите проект в dev версии

```bash
docker compose -f docker-compose.dev.yaml up 
```

### Запуск проекта в prod версии
Желательно добавить переменные среды в `.env`
```
ALLOWED_HOSTS=127.0.0.1,localhost
ROLLBAR_ACCESS_TOKEN=YOUR_ROLLBAR_ACCESS_TOKEN
ROLLBAR_NAME=YOUR_ROLLBAR_NAME
ROLLBAR_ENVIRONMENT=YOUR_ROLLBAR_ENVIRONMENT
```
Далее запускаем проект
```shell
docker compose -f docker-compose.prod.yaml up
```

## Старт dev версии
Необходимо определить переменые среды 

```
YANDEX_API_KEY=YOUR_YANDEX_API_KEY
SECRET_KEY=YOUR_SECRET_KEY
PG_USER=root
PG_PASSWORD=SecretPassword
PG_DB=db_name
```
- `SECRET_KEY` — секретный ключ проекта. Он отвечает за шифрование на сайте. Например, им зашифрованы все пароли на вашем сайте.
- `YANDEX_API_KEY` — Получить токен  YANDEX_API_KEY можно получить по следующей ссылке https://developer.tech.yandex.ru/services/3
- `PG_USER` — имя пользователя базы данных (Опционально)
- `PG_PASSWORD` — пароль пользователя базы данных (Опционально)
- `PG_DB` — название базы данных (Опционально)
```bash
docker run --env-file .env -p 8000:8000 -it star-burger:1.0.2dev
```
# Docker
В докер hub есть версии проекта с dev и prod версиями. 
Например, `elzig1999/star-burger:<version>dev` - dev версия проекта.
`elzig1999/star-burger:<version> .prod` - prod версия проекта.

# Kubernetes 
## Быстрый старт
Для запуска проекта в Kubernetes. Запустите minikube
```shell
minikube start --driver docker
```
Запустите проект с помощью контейнера `elzig1999/star-burger:<tag>`
Пример запуска dev версии
```shell
kubectl run star-burger-pod --image=elzig1999/star-burger:1.0.2dev --env=YANDEX_API_KEY=YOUR_YANDEX_API_KEY \
--env=SECRET_KEY=YOUR_SECRET_KEY --port=8000 
```

