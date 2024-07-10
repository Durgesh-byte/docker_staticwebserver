pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'dksingh345/mystaticwebimage' // Update if necessary
        DOCKER_TAG = 'latest'
    }

    stages {
        stage('Cleanup') {
            steps {
                cleanWs()
            }
        }

        stage('Clone Repository') {
            steps {
                checkout([$class: 'GitSCM', branches: [[name: '*/master']], 
                doGenerateSubmoduleConfigurations: false, extensions: [], 
                submoduleCfg: [], userRemoteConfigs: [[url: 'https://github.com/Durgesh-byte/docker_staticwebserver.git']]]) // Update if necessary
            }
        }

        stage('Verify Files') {
            steps {
                sh 'ls -l'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("${DOCKER_IMAGE}:${DOCKER_TAG}", ".")
                }
            }
        }

        stage('Test Docker Image') {
            steps {
                script {
                    sh 'docker run -d --name test-apache ${DOCKER_IMAGE}:${DOCKER_TAG}'
                    sh 'sleep 10' // Give some time for Apache to start
                    sh 'docker logs test-apache'
                    sh 'docker stop test-apache'
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('', 'docker-hub-credentials-id') { // Use the correct Docker Hub credentials ID
                        docker.image("${DOCKER_IMAGE}:${DOCKER_TAG}").push()
                    }
                }
            }
        }

        stage('Deploy Docker Container') {
            steps {
                script {
                    sh 'docker rm -f my-apache-server || true'
                    sh 'docker run -d --name my-apache-server -p 200:80 ${DOCKER_IMAGE}:${DOCKER_TAG}'
                }
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}
