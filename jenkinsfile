pipeline {
  agent any

  environment {
    IMAGE_NAME = "localhost:8081/demo-app"
    TAG        = "${BUILD_NUMBER}"
  }

  stages {

    stage('Checkout') {
      steps {
        checkout scm
      }
    }

    stage('Build Docker Image') {
      steps {
        bat "docker build -t %IMAGE_NAME%:%TAG% ."
      }
    }

    stage('Login to Nexus Registry') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'nexus-creds', usernameVariable: 'USER', passwordVariable: 'PASS')]) {
          bat "docker login localhost:8081 -u %USER% -p %PASS%"
        }
      }
    }

    stage('Push Docker Image') {
      steps {
        bat "docker push %IMAGE_NAME%:%TAG%"
      }
    }
  }
}
