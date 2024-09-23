#!/bin/bash
#scripts/kill_gunicorn.sh

kill $(ps aux | grep gunicorn | grep -v grep | awk "{print \$2}" | head -n 1)
