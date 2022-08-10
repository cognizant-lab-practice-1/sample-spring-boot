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
            agent {
                docker {
                    image 'jshimko/kube-tools-aws:3.8.1'
                    args '-u root --privileged'
                }
            }

            steps{
                echo 'Deploying to kubernetes'

                withAWS(credentials:'aws-credentials') {
                    sh 'aws eks update-kubeconfig --name sre-primer'
                    sh 'chmod +x deployment-status.sh && ./deployment-status.sh'
                    sh "kubectl set image deployment sample-spring-boot -n zohair-awan springboot-sample=$ENV_DOCKER_USR/$DOCKERIMAGE:$BUILD_ID"
                }
            }
        }
    }
}
