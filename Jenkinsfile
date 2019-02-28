pipeline {
    agent none
    stages {stage('Build & Push Docker Image') {
            agent any
            steps {
                git credentialsId: 'github-abstractvector', url: 'https://github.com/abstractvector/away-php'
                script {
                    def image = docker.build("away-php", "-f Dockerfile .")
                    docker.withRegistry("https://registry.adventurousway.com:5043", 'registry-conductor') {
                        image.push("build-${env.BUILD_ID}")
                        image.push("latest")
                    }
                }
            }
        }
    }
}
