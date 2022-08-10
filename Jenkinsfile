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
        // stage('SonarQube') {
        //     agent {
        //         docker { image 'sonarsource/sonar-scanner-cli:latest' }
        //     }
        //     steps {
        //         echo 'Sonaqube step'
        //         sh 'sonar-scanner'
        //     }
        // }
        stage('Docker Build') {
            agent any
            steps {
                sh 'echo docker build'

                script {
                    image = docker.build("$ENV_DOCKER_USR/$DOCKERIMAGE")
                }
            }
        }
        stage('Docker Push') {
            agent any
            steps {
                sh 'echo docker push!'

                script {
                    docker.withRegistry('', 'dockerhub') {
                        image.push("$BUILD_ID")
                        image.push('latest')
                    }
                }
            }
        }
        stage('Deploy App') {
            steps {
                sh 'echo deploy to kubernetes'               
            }
        }
    }
}
