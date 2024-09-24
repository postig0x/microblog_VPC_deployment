#!/bin/bash
#scripts/setup.sh

# web server script that will SSH into app server to run "start_app.sh"
# APPSERV="10.0.0.26"
# ^^ no longer needed as this IP is stored in /etc/environment

ssh -i .ssh/appservkey.pem ubuntu@$APPSERV "source ./start_app.sh"
