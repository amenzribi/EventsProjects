pipeline {
    agent any

    environment {
        SONAR_TOKEN = credentials('jenkins-token') // Utiliser l'ID de votre token SonarQube enregistré dans Jenkins
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'Events', changelog: false, credentialsId: '87433cf5-3e8f-4e18-a692-84baeef2322c', poll: false, url: 'https://github.com/amenzribi/EventsProjects.git'
            }
        }

        stage('Build and Test') {
            steps {
                sh "mvn clean test"
            }
        }

        stage('Code Quality Analysis') {
            steps {
                withSonarQubeEnv('sonar') { // Utiliser le nom de votre SonarQube serveur configuré dans Jenkins
                    sh """
                        mvn sonar:sonar \
                        -Dsonar.projectKey=Jenkins_sonar \
                        -Dsonar.host.url=http://192.168.33.10:9000 \
                        -Dsonar.login=$SONAR_TOKEN
                    """
                }
            }
        }

        stage('Cleanup') {
            steps {
                deleteDir()
            }
        }
    }

    post {
        success {
            echo 'Pipeline completed successfully!'
        }
        failure {
            echo 'Pipeline failed.'
        }
    }
}
