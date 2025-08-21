pipeline {
    agent any

    environment {
        // IP of the WSL instance where Nexus is running
        REGISTRY_HOST = "172.18.196.94:7000"
        IMAGE_NAME    = "${REGISTRY_HOST}/demo-app"
        TAG           = "${BUILD_NUMBER}"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                bat "docker build -t ${IMAGE_NAME}:${TAG} ."
            }
        }

        stage('Login to Nexus Registry') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'nexus-creds', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
                    bat "docker login http://${REGISTRY_HOST} --username $USER --password $PASS"
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                bat "docker push ${IMAGE_NAME}:${TAG}"
            }
        }
    }
}
