#!/bin/bash
#scripts/jenkins_setup.sh

# update and upgrade system
sudo apt update -y & sudo apt upgrade -y

# install python3.9 and python3.8-venv
sudo apt install fontconfig openjdk-17-jre software-properties-common && \
  sudo add-apt-repository ppa:deadsnakes/ppa && \
  sudo apt install python3.9 python3.9-venv

# verify
echo "\n\n"
python3.9 --version
python3.9 -m venv --help
echo "\n\n"

# install python3-pip
sudo apt install python3-pip

# verify
echo "\n\n"
pip3 --version
echo "\n\n"

# get Jenkins download repo:
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key

echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian-stable binary/ | \
  sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null

# refresh packages
sudo apt-get update

# install jenkins
sudo apt-get install jenkins

# start and enable
sudo systemctl start jenkins

# verify
sudo systemctl status jenkins
