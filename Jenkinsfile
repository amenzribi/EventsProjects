pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Build') {
            steps {
                sh 'mvn clean package' // Adjust Maven command as needed
            }
        }
        stage('Test') {
            steps {
                sh 'mvn test' // Run tests using Maven
            }
        }
        stage('SonarQube Scan') {
            steps {
                withSonarQubeEnv('SonarQube') {
                    sh 'mvn sonar:sonar' // Execute SonarQube analysis
                }
            }
        }
        stage('Deploy to Nexus') {
            steps {
                sh 'mvn deploy' // Deploy artifacts to Nexus
            }
        }
    }

    post {
        always {
            junit '**/target/surefire-reports/*.xml' // Publish JUnit test results
        }
    }
}
