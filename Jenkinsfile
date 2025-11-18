pipeline {
    agent any

    environment {
        APP_NAME = "monapp"
        APP_PORT = "5000"
    }

    stages {
        stage('Clone Git') {
            steps {
                echo 'Clonage du dépôt Git...'
                git branch: 'main', url: 'https://github.com/emmanueleffa/validation.git'
            }
        }

        stage('Build Docker') {
            steps {
                echo 'Construction de l’image Docker...'
                sh 'docker build -t ${APP_NAME}:latest .'
            }
        }
        
        stage('Run Tests') {
            steps {
                // Lancer les tests à l’intérieur du conteneur
                sh 'docker run --rm monapp:latest pytest tests/'
            }
        }

        stage('Free Port if occupied') {
            steps {
                echo "Vérification et libération du port ${APP_PORT}..."
                // Arrête tous les conteneurs qui utilisent ce port
                sh "docker ps --filter publish=${APP_PORT} --format '{{.ID}}' | xargs -r docker stop"
                sh "docker ps -a --filter name=${APP_NAME} --format '{{.ID}}' | xargs -r docker rm"
            }
        }

        stage('Run Docker') {
            steps {
                echo "Lancement du conteneur Docker..."
                sh "docker run -d --name ${APP_NAME} -p ${APP_PORT}:${APP_PORT} ${APP_NAME}:latest"
            }
        }

        // Si tu veux lancer Semgrep (installé globalement sur le serveur Jenkins)
        stage('Run Semgrep Scan') {
            steps {
                echo "Lancement du scan Semgrep..."
                sh 'semgrep --config=auto . || true'
            }
        }
    }

    post {
        always {
            echo "Pipeline terminé."
        }
        success {
            echo "La pipeline a réussi ✅"
        }
        failure {
            echo "La pipeline a échoué ❌"
        }
    }
}

