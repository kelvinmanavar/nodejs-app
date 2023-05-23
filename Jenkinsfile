pipeline {
    agent any
    environment {
        DOCKER_HUB_CREDENTIALS = 'docker-hub-credentials' // Jenkins credentials ID for Docker Hub
        DOCKER_IMAGE_NAME = 'nodejsrepo/node-app' // Replace with your Docker Hub repository name
        DOCKER_IMAGE_TAG = 'latest' // Replace with your desired image tag
    }    
    stages {
        stage('Build') {
            steps {
                // Checkout your source code from version control system
                // e.g., git checkout or svn checkout
 
                // Build the Docker image
                script {
                    docker.withRegistry('', DOCKER_HUB_CREDENTIALS) {
                        def dockerImage = docker.build("${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}")
                        dockerImage.push()
                    }
                }
            }
        }

        stage('Push Image') {
            steps {
                // Push the Docker image to a registry
                sh 'docker push nodejsrepo/node-app'
            }
        }
        stage('Deploy') {
            steps {
                // Deploy the Docker image to your EC2 instances behind the load balancer
                script {
                    sshagent(['aws-ec2']) {
                        // SSH into each EC2 instance and pull the latest Docker image
                    sh '''
                        ssh -o StrictHostKeyChecking=no ubuntu@ec2-13-127-29-25 <<EOF
                        docker pull nodejsrepo/node-app
                        docker run -d --name node-app-container -p 8000:8000 nodejsrepo/node-app
                        EOF
                    '''
                    }
                }
            }
        }
    }
}
