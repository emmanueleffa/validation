pipeline {
    agent any
    environment {
        APP_NAME = "monapp"
        APP_PORT = "5000"
        IMAGE_NAME = "monapp:latest"
        SEMGREP_RULES = "p/ci"  // tu peux changer selon les règles souhaitées
    }
    stages {
        stage('Clone Git') {
            steps {
                echo "Clonage du dépôt Git..."
                git branch: 'main', url: 'https://github.com/emmanueleffa/validation.git'
            }
        }

        stage('Build Docker') {
            steps {
                echo "Construction de l’image Docker..."
                sh "docker build -t ${IMAGE_NAME} ."
            }
        }

        stage('Run Tests') {
            steps {
                echo "Exécution des tests dans le conteneur..."
                sh "docker run --rm ${IMAGE_NAME} pytest tests/"
            }
        }

        stage('Semgrep Scan') {
            steps {
                echo "Analyse de sécurité avec Semgrep..."
                sh """
                # Installer semgrep si nécessaire
                if ! command -v semgrep &> /dev/null; then
                    pip install semgrep
                fi

                # Lancer le scan
                semgrep --config ${SEMGREP_RULES} .
                """
            }
        }

        stage('Free Port 5000 if occupied') {
            steps {
                echo "Vérification et libération du port ${APP_PORT} si occupé..."
                sh """
                docker ps -q --filter publish=${APP_PORT} | xargs -r docker stop
                docker ps -aq --filter publish=${APP_PORT} | xargs -r docker rm
                """
            }
        }

        stage('Run Docker') {
            steps {
                echo "Lancement du conteneur Docker..."
                sh "docker run -d --name ${APP_NAME} -p ${APP_PORT}:${APP_PORT} ${IMAGE_NAME}"
            }
        }
    }

    post {
        always {
            echo "Pipeline terminé."
        }
        failure {
            echo "La pipeline a échoué ❌"
        }
        success {
            echo "La pipeline s'est terminée avec succès ✅"
        }
    }
}

