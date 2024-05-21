
### Установка веб-сервера Apache2
`$ sudo apt install apache2`

### Настройка Apache2

_/etc/apache2/ports.conf_ \
<img src="images/8.png" alt="03" width="800"/>

### Перезапуск Apache2
`$ sudo service apache2 restart`

### Настроим Prometheus для связывания его с нашей страничкой:

`$ sudo nano /etc/prometheus/prometheus.yml` 

_Допишем в файл prometheus.yml в раздел scrabe_configs следующие строки:_

```

...

scrabe_configs:

...

  - job_name: "my_export"
    static_configs:
      - targets: ["localhost:80"]
```

## Запустим наш скрипт с правами админа:
<img src="images/2.png" alt="04_" width="800"/>

_Таргеты в веб-интерфейсе Prometheus:_ \
<img src="images/1.png" alt="04_" width="800"/>

## Создадим в Grafana новый дашборд с тремя панелями, собирающими информацию с нашей странички

_Дашборд My Dashboard:_ \
<img src="images/3.png" alt="04_" width="800"/>

## Запустим скрипт из второго задания

_Запуск скрипта:_ \
<img src="images/4.png" alt="04_" width="800"/>

_Результаты запуска скрипта:_ \
<img src="images/5.png" alt="04_" width="800"/>

## Утилита Stress

_Запуск утилиты:_ \
<img src="images/6.png" alt="04_" width="800"/>

_Результаты запуска утилиты:_ \
<img src="images/7.png" alt="04_" width="800"/>