pipeline {
  agent any
    stages {
        stage ('Build') {
            steps {
                sh '''#!/bin/bash
                python3.9 -m venv venv
                source venv/bin/activate
                pip install -r requirements.txt
                pip install gunicorn pymysql crypotgraphy
                FLASK_APP=microblog.py
                flask translate compile
                flask db upgrade
                '''
            }
        }
        stage ('Test') {
            steps {
                sh '''#!/bin/bash
                source venv/bin/activate
                py.test ./tests/unit/ --verbose --junit-xml test-reports/results.xml
                '''
            }
            post {
                always {
                    junit 'test-reports/results.xml'
                }
            }
        }
      stage ('OWASP FS SCAN') {
            steps {
                withCredentials([string(credentialsId: 'NVD_API_KEY', variable: "NVD_API_KEY")]) {
                    dependencyCheck additionalArguments: '--scan ./ --disableYarnAudit --disableNodeAudit --nvdApiKey ${NVD_API_KEY}', odcInstallation: 'DP-Check'
                    dependencyCheckPublisher pattern: '**/dependency-check-report.xml'
                }
            }
        }
      stage ('Deploy') {
            steps {
                sh '''#!/bin/bash
                ssh -i ~/.ssh/webservkey ubuntu@$WEBSERV "./setup.sh"
                '''
            }
        }
    }
}
