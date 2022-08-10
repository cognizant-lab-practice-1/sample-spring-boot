pipeline {
    agent none
        environment {
        ENV_DOCKER = credentials('dockerhub')
        SONAR_TOKEN = credentials('sonar')
        DOCKERIMAGE = "cog-lab-practice-one"
        EKS_CLUSTER_NAME = "demo-cluster"
    }
    stages {
        stage('Build') {
            agent {
                docker { image 'openjdk:11-jdk' }
            }
            steps {
                sh 'chmod +x gradlew && ./gradlew build jacocoTestReport'
            }
        }
        stage('SonarQube') {
            agent {
                docker { image 'sonarsource/sonar-scanner-cli:latest' }
            }
            steps {
                echo 'Sonaqube step'
                sh 'sonar-scanner'
            }
        }
        stage('Docker Build') {
            steps {
                sh 'echo docker build'
            }
        }
        stage('Docker Push') {
            steps {
                sh 'echo docker push!'
                }
            }
        stage('Deploy App') {
            steps {
                sh 'echo deploy to kubernetes'               
            }
        }
    }
}
