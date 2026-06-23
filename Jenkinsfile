pipeline {
    agent any

    environment {
        DOCKERHUB_USER = 'kmcshane'
        IMAGE_NAME = 'survey-app-hw2'
        IMAGE_TAG = 'latest'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/kmcshane/swe645-survey-app-hw2.git'
            }
        }

        
        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("${DOCKERHUB_USER}/${IMAGE_NAME}:${IMAGE_TAG}")
                }
            }
        }
        
        stage('Push to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io/v1/', 'dockerhub-pass') {
                        dockerImage.push()
                    }
                }
            }
        }
        
        stage('Update Kubernetes Deployment') {
            steps {
                script {
                    withCredentials([file(credentialsId: 'kubeconfig-id', variable: 'KUBECONFIG')]) {
                        sh """
                        sed -i 's|kmcshane/survey-app-hw2:latest|${DOCKERHUB_USER}/${IMAGE_NAME}:${IMAGE_TAG}|' k8s/deployment.yaml
                        kubectl apply -f k8s/deployment.yaml
                        kubectl apply -f k8s/service.yaml
                        """
                    }
                }
            }
        }
    }
    
    post {
        success {
            echo 'Deployment successful!'
        }
        failure {
            echo 'Deployment failed.'
        }
    }
}
