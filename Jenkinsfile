pipeline {
    agent any
    environment {
        DOCKER_HUB_CREDENTIALS = 'docker-hub-credentials' // Jenkins credentials ID for Docker Hub
        DOCKER_IMAGE_NAME = 'kelvinmanavar/node-app' // Replace with your Docker Hub repository name
        DOCKER_IMAGE_TAG = 'latest' // Replace with your desired image tag
    }       
    stages {

        stage("Verify SSH connection to server") {
            steps {
                sshagent(credentials: ['aws-ec2']) {
                    sh '''
                        ssh -o StrictHostKeyChecking=no ubuntu@13-127-29-25 whoami
                    '''
                }
            }
        }        
        stage('Build') {
            steps {
                // Checkout your source code from version control system
                // e.g., git checkout or svn checkout
 
                // Build the Docker image
                script {
                    docker.withRegistry('https://registry.hub.docker.com', DOCKER_HUB_CREDENTIALS) {
                        def dockerImage = docker.build("${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}")
                        dockerImage.push()
                    }
                }
            }
        }

        stage('Deploy') {
            steps {
                // Deploy the Docker image to your EC2 instances behind the load balancer
                script {
                    sshagent(credentials: ['aws-ec2']) {
                        // SSH into each EC2 instance and pull the latest Docker image
                        sh 'ssh -o StrictHostKeyChecking=no ubuntu@13-127-29-25 "docker pull kelvinmanavar/node-app:${DOCKER_IMAGE_TAG} && docker-compose up -d"'
                    }
                }
            }
        }
    }
}
