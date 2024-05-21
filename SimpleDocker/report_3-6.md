## Part 3. Мини веб-сервер

* Написать мини сервер на **C** и **FastCgi**, который будет возвращать простейшую страничку с надписью `Hello World!`
* Запустить написанный мини сервер через *spawn-fcgi* на порту 8080
* Написать свой *nginx.conf*, который будет проксировать все запросы с 81 порта на *127.0.0.1:8080*
* Проверить, что в браузере по *localhost:81* отдается написанная вами страничка
* Положить файл *nginx.conf* по пути *./nginx/nginx.conf* (это понадобится позже)
```
// В папке server вводим команды
$ sudo apt install libfcgi-dev
$ gcc fastcgi.c -o miniserver -lfcgi -O3 -Wall -Wextra
$ sudo docker pull nginx
$ sudo docker run -d --name fastcgi_nginx -p 81:81 nginx
$ sudo docker cp nginx.conf fastcgi_nginx:/etc/nginx/nginx.conf
$ sudo docker cp miniserver fastcgi_nginx:/home/miniserver
$ sudo docker exec -it fastcgi_nginx bash
$ apt update
$ apt install spawn-fcgi libfcgi-dev 
$ cd home
$ spawn-fcgi -p 8080 miniserver
$ nginx -s reload
$ exit
// After restart container
$ sudo docker start fastcgi_nginx
$ sudo docker exec fastcgi_nginx spawn-fcgi -p 8080 /home/miniserver
```

## Part 4. Свой докер

#### Собрать написанный докер образ через `docker build` при этом указав имя и тег
* В директории `src` запускаем `sudo docker build -t webimage:v1 -f dockerfile4 .`

#### Проверить через `docker images`, что все собралось корректно
* `sudo docker images`

#### Запустить собранный докер образ с маппингом 81 порта на 80 на локальной машине и маппингом папки *./nginx* внутрь контейнера по адресу, где лежат конфигурационные файлы **nginx**'а.
* `sudo docker run -d -p 80:81 --name mycont -v ./nginx:/etc/nginx webimage:v1`
#### Проверить, что по localhost:80 доступна страничка написанного мини сервера
#### Дописать в *./nginx/nginx.conf* проксирование странички */status*, по которой надо отдавать статус сервера **nginx**
#### Перезапустить докер образ
* `sudo docker stop mycont`
* `sudo docker start mycont`

#### Проверить, что теперь по *localhost:80/status* отдается страничка со статусом **nginx**

## Part 5. **Dockle**

* Просканировать образ из предыдущего задания через `dockle [image_id|repository]`
* Исправить образ так, чтобы при проверке через **dockle** не было ошибок и предупреждений

## Part 6. Базовый **Docker Compose**

* Написать файл *docker-compose.yml*, с помощью которого:
* 1) Поднять докер контейнер из [Части 5](#part-5-инструмент-dockle) _(он должен работать в локальной сети, т.е. не нужно использовать инструкцию **EXPOSE** и мапить порты на локальную машину)_
* 2) Поднять докер контейнер с **nginx**, который будет проксировать все запросы с 8080 порта на 81 порт первого контейнера
* Замапить 8080 порт второго контейнера на 80 порт локальной машины
* Собрать и запустить проект с помощью команд `docker-compose build` и `docker-compose up`
* Проверить, что в браузере по *localhost:80* отдается написанная вами страничка, как и ранее

