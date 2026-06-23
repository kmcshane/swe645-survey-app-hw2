// Karen McShane
// This is my Jenkinsfile. It will clone my code, build and push my container, and redeploy into my kubernetes cluster
pipeline {
    agent any

    environment {
        DOCKERHUB_USER = 'kmcshane'
        IMAGE_NAME = 'survey-app-hw2'
        IMAGE_TAG = ''
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/kmcshane/swe645-survey-app-hw2.git'

                // Set the commit hash variable right after cloning the repo
                script {
                    IMAGE_TAG = sh(script: 'git rev-parse --short HEAD', returnStdout: true).trim()
                    echo "Current Image Tag set to: ${IMAGE_TAG}"
                }
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
