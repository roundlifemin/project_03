pipeline {
    agent any


   // environment{
           //def dockerUsername = 'your_dockerhub_username' // Docker Hub 사용자 이름
           //def dockerToken = 'your_access_token' // 생성한 액세스 토큰

	   //dockerUsername = 'roundlifemin'
	   //dockerToken = 'dockerhub_access_key'
   //}


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
		     //   docker build  -f ./Dockerfile -t roundlifemin/project_03:latest .


                    
                   bat  'docker build  -f ./Dockerfile -t roundlifemin/project_03:latest .'
		       
                    
             }
            }
        }


       stage('Push') {
            steps {
                script {
                      // Docker Hub에 로그인
                      // bat  'echo minyoung1234!@#$ | docker login -u roundlifemin --password-stdin'

		      withCredentials([usernamePassword(credentialsId: 'dockerhub_access_key', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_TOKEN')]) {
                        bat "echo ${DOCKER_TOKEN} | docker login -u ${DOCKER_USERNAME} --password-stdin"
                    }

		        // Docker 이미지 푸시
                       bat 'docker push roundlifemin/project_03:latest'
                  
                }
            }
        }





stage("deploy application on kubernetes cluster") {
            steps {
                withKubeConfig([
                    credentialsId: "kubernetes_access_key",
                    serverUrl: "https://kubernetes.default",
                    namespace: "default"
                ]) {
                    sh '''
                    kubectl apply -f deploy-nginx.yaml
                    kubectl apply -f service-nginx.yaml
                    '''
                }
            }
        }
    }

      


       stage('Finish') {
            steps{
                bat 'echo Build and deploy complete.'
                bat 'docker images -qf dangling=true | xargs -I{} docker rmi {}'
            }
        }



    }
}

