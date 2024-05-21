# Basic CI/CD

- #### Скачивание, установка и регистрация **gitlab-runner** на виртуальной машине 
```
curl -LJO "https://gitlab-runner-downloads.s3.amazonaws.com/latest/deb/gitlab-runner_amd64.deb"
sudo dpkg -i gitlab-runner_amd64.deb
paha@gitlab:~$ sudo gitlab-runner register
Runtime platform                                    arch=amd64 os=linux pid=1206 revision=853330f9 version=16.5.0
Running in system-mode.
Enter the GitLab instance URL (for example, https://gitlab.com/):
https://repos.21-school.ru
Enter the registration token:
xxxxxxxxxxxxxxxxxxxx
Enter a description for the runner:
[gitlab]: simplebashutils_runner
Enter tags for the runner (comma-separated):
gitlab,gitlab-runner
Enter optional maintenance note for the runner:
WARNING: Support for registration tokens and runner parameters in the 'register' command has been deprecated in GitLab Runner 15.6 and will be replaced with support for authentication tokens. For more information, see https://docs.gitlab.com/ee/ci/runners/new_creation_workflow
Registering runner... succeeded                     runner=g6eRMNq6
Enter an executor: docker-windows, parallels, ssh, docker+machine, custom, docker, docker-autoscaler, instance, kubernetes, shell, virtualbox:
shell
Runner registered successfully. Feel free to start it, but if it's running already the config should be automatically reloaded!
Configuration (with the authentication token) was saved in "/etc/gitlab-runner/config.toml"
```

- #### Перед этапом CD Deploy, для разрешения копирования файлов на prod-машину на машине с gitlab-runner выполнить
```
sudo su gitlab-runner
ssh-keygen
ssh-copy-id -p 2022 paha@10.10.0.2
```

- #### Создать telegram-бота и узнать требуемый Telegram User ID по инструкциям из интернета. Перед отправкой ботом сообщений следует один раз самому отправить сообщение этому боту