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
               {
                    sh "mvn clean test"
                }
            }
        }

        stage('Cleanup') {
            steps {
                deleteDir() //
            }
        }
    }
}