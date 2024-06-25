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
                      sh "mvn clean test -X"
                  }
              }




        stage('Code Quality Analysis') {
            steps {
                withSonarQubeEnv('sonar') {
                    sh """
                        mvn sonar:sonar \
                        -Dsonar.projectKey=Jenkins_sonar \
                        -Dsonar.host.url=http://192.168.33.10:9000 \
                        -Dsonar.login=admin \
                        -Dsonar.password=sonarqube
                    """
                }
            }
        }

        stage('Deploy to Nexus') {
            steps {
                sh "mvn deploy"
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
