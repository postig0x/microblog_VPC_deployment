#!/bin/bash
#scripts/kill_gunicorn.sh

ps aux | grep gunicorn | grep -v grep | awk "{print $2}" | head -n 1
kill $(ps aux | grep gunicorn | grep -v grep | awk "{print $2}" | head -n 1)
