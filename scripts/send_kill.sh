#!/bin/bash
#scripts/send_kill.sh

# app server IP
# APPSERV="10.0.0.26"
# ^ no longer needed, stored in /etc/environment

# ssh to app server and kill gunicorn
ssh -i .ssh/appservkey.pem ubuntu@$APPSERV "./kill_gunicorn.sh"
