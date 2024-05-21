# Использование готового дашборда в Grafana

#### Установим дашборд *Node Exporter Quickstart and Dashboard* с официального сайта **Grafana Labs**. Для этого узнаем на сайте ID дашборда (13978). Далее в веб-интерфейсе Grafana выберем Dashboards -> Browse -> Import. Введем ID, нажмем LOAD, затем IMPORT

<img src="images/5.png" alt="03_-_Prometheus_web_UI.png" width="800"/>

#### Запустим скрипт из второго задания и посмотрим рузультатт в Графане:
<img src="images/2.png" alt="09_-_Script_from_part_2_runned.png" width="800"/>

<img src="images/1.png" alt="09_-_Script_from_part_2_runned.png" width="800"/>


#### Запустим утилиту stress и посмотрим рузультат в Графане:
<img src="images/3.png" alt="10_-_Stress_utility_runned.png" width="800"/>

<img src="images/4.png" alt="11_-_Result_of_Stress_utility_run.png" width="800"/>

#### Запустим ещё одну виртуальную машину, находящуюся в одной сети с текущей. Запустим тест нагрузки сети с помощью утилиты **iperf3**. Посмотрим нагрузку сети в Графане:
<img src="images/6.png" alt="10_-_Stress_utility_runned.png" width="800"/>

<img src="images/7.png" alt="11_-_Result_of_Stress_utility_run.png" width="800"/>

<img src="images/8.png" alt="10_-_Stress_utility_runned.png" width="800"/>
