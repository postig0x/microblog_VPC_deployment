pipeline {
  agent any
    stages {
        stage ('Build') {
            when {
              branch 'main'
            }
            steps {
                sh '''#!/bin/bash
                python3.9 -m venv venv
                source venv/bin/activate
                pip install -r requirements.txt
                pip install gunicorn pymysql cryptography
                FLASK_APP=microblog.py
                flask translate compile
                flask db upgrade
                '''
            }
        }
        stage ('Test') {
            when {
              branch 'main'
            }
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
            when {
              branch 'main'
            }
            steps {
                withCredentials([string(credentialsId: 'NVD_API_KEY', variable: "NVD_API_KEY")]) {
                    dependencyCheck additionalArguments: '--scan ./ --disableYarnAudit --disableNodeAudit --nvdApiKey ${NVD_API_KEY}', odcInstallation: 'DP-Check'
                    dependencyCheckPublisher pattern: '**/dependency-check-report.xml'
                }
            }
        }
      stage ('Deploy') {
            when {
              branch 'main'
            }
            steps {
                withCredentials([sshUserPrivateKey(credentialsId: 'webservkey', keyFileVariable: 'WEBSERV_KEY')]) {
                    sh '''#!/bin/bash
                    source /etc/environment
                    echo "setting up web server: ${WEBSERV}"
                    ssh -i ${WEBSERV_KEY} ubuntu@${WEBSERV} "./setup.sh"
                    '''
                }
            }
        }
    }
}
