#!/bin/bash
#scripts/start_app.sh

# script that will run on application server
# - set up environment (python)
# - clone gh repo
# - install app dependencies
# - app setup
#   - ENV variables
#   - flask commands (db setup)
# - serve app with gunicorn

# update and upgrade system
sudo apt update -y && sudo upgrade -y

# repo vars
REPO_URL="https://github.com/postig0x/microblog_VPC_deployment.git"
REPO_DIR="~/microblog_VPC_deployment"

# check if repo already exists
# if it does, git pull
# otherwise git clone
if [[ -d "$REPO_DIR" ]]
then
  cd "$REPO_DIR"
  git pull
else
  git clone "$REPO_URL" "$REPO_DIR"
fi

cd "$REPO_DIR"

# check if python3.9 is installed
if ! command -v python3.9 &> /dev/null
then
  # install python3.9 and python3.9-venv
  sudo apt install -y fontconfig openjdk-17-jre software-properties-common && \
    sudo add-apt-repository -y ppa:deadsnakes/ppa && \
    sudo apt install -y python3.9 python3.9-venv

  # verify
  echo -e "\n\n"
  python3.9 --version
  python3.9 -m venv --help
  echo -e "\n\n"
fi

# check if pip3 is installed
if ! command -v pip3 &> /dev/null
then
  # install python3-pip 
  sudo apt install -y python3-pip
  # verify
  echo -e "\n\n"
  pip3 --version
  echo -e "\n\n"
fi

# create virtual environment if it doesn't exist
if [[ ! -d "venv" ]]
then
  python3.9 -m venv venv
fi

# activate venv
source venv/bin/activate
pip install -r requirements.txt
pip install gunicorn pymysql cryptography

# export FLASK_APP environment variable if not set
if [[ -z "$FLASK_APP" ]]
then
  export FLASK_APP=microblog.py
fi

# run flask setup
flask translate compile
flask db upgrade

# serve app
gunicorn -b :5000 -w 4 microblog:app & disown
