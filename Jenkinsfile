pipeline {
    agent any
    stages {
        stage('Clone') {
            steps {
                git url: 'https://github.com/emmanueleffa/validation.git', branch: 'main'
            }
        }
        stage('Build') {
            steps {
                echo 'Compilation du projet...'
            }
        }
        stage('Test') {
            steps {
                echo 'Tests unitaires...'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Déploiement...'
                sh 'docker build -t monapp:latest .'
                sh 'docker run -d -p 5000:5000 monapp:latest'
            }
        }
    }
}
