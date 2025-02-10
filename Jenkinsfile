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





      

      stage('Deploy to Kubernetes') {
            steps {
                script {
		       withCredentials([usernamePassword(credentialsId: 'kubernetes_access_key', usernameVariable: 'KUBE_USER', passwordVariable: 'KUBE_PASSWORD')]) {
                  
 		    bat 'kubectl config set-credentials ${KUBE_USER} --token=${KUBE_PASSWORD}'
                    }	    

		  //  bat 'scp -P 105 deploy-nginx.yaml ubuntu@127.0.0.1:/home/ubuntu'
		  //  bat 'scp -P 105 service-nginx.yaml ubuntu@127.0.0.1:/home/ubuntu'

                    bat 'kubectl apply -f /home/ubuntu/deploy-nginx.yaml'
                    bat 'kubectl apply -f /home/ubuntu/service-nginx.yaml'
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

