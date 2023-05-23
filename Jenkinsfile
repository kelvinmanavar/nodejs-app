pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                // Checkout your source code from version control system
                // e.g., git checkout or svn checkout

                // Build the Docker image
                sh 'docker build -t node-app .'
            }
        }

        stage('Deploy') {
            steps {
                // Stop and remove the existing container (if necessary)
                sh 'docker stop node-app-container || true'
                sh 'docker rm node-app-container || true'

                // Run the Docker container
                sh 'docker run -d --name node-app-container -p 3000:3000 node-app'
            }
        }
    }
}
