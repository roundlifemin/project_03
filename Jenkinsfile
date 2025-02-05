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
		    
                     // bat 'docker build  -f ./Dockerfile -t roundlifemin/project_03:latest .'

		     sh ...
                        docker build  -f ./Dockerfile -t roundlifemin/project_03:latest .
		       ...
		    
		       
                }
            }
        }


       stage('Push') {
            steps {
                script {
                      // Docker 이미지 푸시
                   sh ...
                       sh  docker push roundlifemin/project_03:latest
                      ...
                }
            }
        }



    }
}

