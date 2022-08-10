pipeline {
    agent none
        environment {
        ENV_DOCKER = credentials('dockerhub')
        DOCKERIMAGE = "dummy/dummy"
        EKS_CLUSTER_NAME = "demo-cluster"
    }
    stages {
        stage('Code Build') {
            agent {
                docker { image 'openjdk:11-jdk' }
            }
            steps {
                sh 'chmod +x gradlew && ./gradlew build jacocoTestReport'
            }
        }
        stage('SonarQube') {
        agent {
            docker { image '<some sonarcli image>' } }
            steps {
                sh 'echo scanning!'
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
