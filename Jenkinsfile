pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                git branch: 'Events', changelog: false, credentialsId: '87433cf5-3e8f-4e18-a692-84baeef2322c', poll: false, url: 'https://github.com/amenzribi/EventsProjects.git'
            }
        }

        stage('Build and Test') {
            steps {
                sh "mvn clean package"
            }
        }

        stage('Containerize and Deploy') {
            steps {
                script {
                    // Construire l'image Docker
                    docker.build("my-events-app")

                    // Démarrer les conteneurs avec Docker Compose
                    dockerCompose(
                        credentialsId: 'docker-hub-credentials',
                        dockerComposeFile: 'docker-compose.yml',
                        dockerComposePath: '.'
                    )
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
