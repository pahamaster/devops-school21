#!/bin/bash

TELEGRAM_BOT_TOKEN="6848204061:AAE8veum41uAHnsGXnTzmRHEvjseu17wMsE"
TELEGRAM_USER_ID="5501944746"
URL="https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/sendMessage"
TEXT="Author:+$CI_COMMIT_AUTHOR%0AJob name: $CI_JOB_NAME%0AStatus:+$CI_JOB_STATUS%0AProject:+$CI_PROJECT_NAME"

curl -s -d "chat_id=$TELEGRAM_USER_ID&disable_web_page_preview=1&text=$TEXT" $URL > /dev/null