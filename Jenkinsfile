pipeline {
    agent any

    environment {
       DOCKERHUB_CREDENTIALS = credentials('hbaDockerHub')
    }

    stages {
        stage('Checkout') {
            steps {
                echo "Getting Project from Git"
                git branch: 'Events', changelog: false, credentialsId: '87433cf5-3e8f-4e18-a692-84baeef2322c', poll: false, url: 'https://github.com/amenzribi/EventsProjects.git'
            }
        }

        stage('Test Backend') {
            steps {
                script {
                    sh 'mvn clean test'
                }
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

                failure {
                    mail(
                        subject: "Build Failure - ${currentBuild.fullDisplayName}",
                        body: "The build has failed in the Jenkins pipeline. Please investigate and take appropriate action.",
                        to: "zribiamen3@gmail.com"
                    )
                }
            }
        }

        stage('Login Docker') {
            steps {
                sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
            }
        }

        stage('Push Docker Image to DockerHub') {
            steps {
                script {
                    def dockerImage = 'amenzribi/eventsproject'
                    sh "docker build -t $dockerImage ."
                    sh "docker push $dockerImage"
                }
            }
        }

        stage('Docker Compose') {
            steps {
                script {
                    sh 'docker-compose down'
                    sh 'docker-compose up -d'
                }
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
