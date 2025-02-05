pipeline {
    agent any
    stages {
        stage('Checkout') {
            steps {
              //  git 'https://github.com/roundlifemin/project_03.git'
	        checkout scm
            }
       }



           stage('Build') {
            steps {
                script {
                    // Docker 이미지 빌드
		    
                      bat 'docker build  -f ./Dockerfile -t roundlifemin/project_03:latest .'

		     
                     //   docker build  -f ./Dockerfile -t roundlifemin/project_03:latest .
		    
		    
		       
                }
            }
        }


       stage('Push') {
            steps {
                script {
                      // Docker Hub에 로그인
                       bat sh 'echo minyoung1234!@#$ | docker login -u roundlifemin --password-stdin'

		        // Docker 이미지 푸시
                       bat 'docker push roundlifemin/project_03:latest'
                  
                }
            }
        }



    }
}

