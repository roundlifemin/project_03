pipeline {
    agent any
    
    

    stages {
        
        
        stage('Checkout') {
            steps {
                git 'https://github.com/roundlifemin/project_03.git'
            }
       }
    
        stage('Build') {
            steps {
                script {
                    // Docker 이미지 빌드
                    sh 'docker build  -f ./Dockerfile -t project_03:latest .'
                }
            }
        }
        stage('Push') {
            steps {
                script {
                    // Docker Hub에 로그인
                    sh 'echo minyoung1234!@#$ | docker login -u roundlifemin --password-stdin'
                    // Docker 이미지 푸시
                    sh 'docker push roundlifemin/project_03:latest'
                }
            }
        }
    }
}

