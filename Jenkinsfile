	     
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






stage("SSH Into k8s Server") {
	
        steps('Put myapp-deployment.yml') {

	   script {

                def remote = [
                        host: '10.0.2.10',
                        user: 'ubuntu',
                        password: 'ubuntu',
                        allowAnyHosts: true
                    ]


	       sshPut remote: remote, from: 'C:/ProgramData/Jenkins/.jenkins/workspace/project_03/deploy-nginx.yaml', into: '/home/ubuntu'          

               sshPut remote: remote, from: 'C:/ProgramData/Jenkins/.jenkins/workspace/project_03/service-nginx.yaml', into: '/home/ubuntu'

            }
	  }

  } 
}

    stage("Deploy to Kubernetes (k8s-master)") {
    steps {
        script {
            // Kubernetes 클러스터에 접속하기 위한 kubeconfig 파일 사용
            withCredentials([file(credentialsId: 'kubeconfig_id', variable: 'KUBECONFIG')]) {
                bat """
		
                kubectl --kubeconfig=%KUBECONFIG% apply -f deploy-nginx.yaml
                kubectl --kubeconfig=%KUBECONFIG% apply -f service-nginx.yaml

                // 배포 확인
                kubectl --kubeconfig=%KUBECONFIG% get pods -o wide
                kubectl --kubeconfig=%KUBECONFIG% get services
                """
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

