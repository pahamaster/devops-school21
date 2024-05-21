# Отчёт по установке и использованию GoAccess

### Настром сеть на виртуальной машине следующим образом

<img src="images/1.png" alt="03_-_Prometheus_web_UI.png" width="800"/>

<img src="images/2.png" alt="03_-_Prometheus_web_UI.png" width="800"/>

Таким образом из host-машины будем обращаться к виртуальной машине по адресу 192.168.1.50

### Установка и запуск GoAccess:
```
$ sudo apt install goaccess
$ goaccess -a logs/*.log --log-format=COMBINED
```
_Запуск GoAccess:_ \
<img src="images/3.png" alt="03_-_" width="800"/>

_Вывод GoAccess:_ \
<img src="images/4.png" alt="03_-_" width="800"/>

### Установка веб-сервера Apache2
`$ sudo apt install apache2`

### Настройка Apache2

_/etc/apache2/ports.conf_ \
<img src="images/5.png" alt="03" width="800"/>

### Перезапуск Apache2
`$ sudo service apache2 restart`

### Запуск GoAcces в режие html
`$ sudo goaccess -a logs/*.log --log-format=COMBINED --real-time-html -o /var/www/html/index.html`

<img src="images/6.png" alt="03" width="800"/>

### Просмотр страницы GoAcces на host-машине
<img src="images/7.png" alt="03" width="800"/>