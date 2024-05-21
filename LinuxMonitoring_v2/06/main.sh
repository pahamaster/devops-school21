
#!/bin/bash

goaccess -a ../04/logs/*.log --log-format=COMBINED --real-time-html -o /var/www/html/index.html
