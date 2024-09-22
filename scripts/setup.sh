#!/bin/bash
#scripts/setup.sh

# web server script that will SSH into app server to run "start_app.sh"
APPSERV="10.0.0.26"

ssh -i .ssh/appservkey.pem ubuntu@$APPSERV "source ./start_app.sh"
