pipeline {
    agent any
    environment {
        AWS_ACCOUNT_ID="364021107285"
        AWS_DEFAULT_REGION="ap-northeast-1"
	    CLUSTER_NAME="connpass-frontend"
	    SERVICE_NAME="frontend"
	    TASK_DEFINITION_NAME="connpass-frontend"
	    DESIRED_COUNT="1"
        IMAGE_REPO_NAME="connpass-frontend"
        IMAGE_TAG="${env.BUILD_ID}"
        REPOSITORY_URI = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}"
	    registryCredential = "demo-admin-user"
    }

    stages {

    // Tests
    stage('Tests') {
      steps{
        script {
          sh "echo 'Hello World'"
        }
      }
    }

    // Building Docker images
    stage('Building image') {
      steps{
        script {
          dockerImage = docker.build "${IMAGE_REPO_NAME}:${IMAGE_TAG}"
        }
      }
    }

    // Uploading Docker images into AWS ECR
    stage('Pushing to ECR') {
     steps{
         script {
			docker.withRegistry("https://" + REPOSITORY_URI, "ecr:${AWS_DEFAULT_REGION}:" + registryCredential) {
                    	dockerImage.push()
                	}
         }
        }
      }

    stage('Deploy') {
     steps{
            withAWS(credentials: registryCredential, region: "${AWS_DEFAULT_REGION}") {
                script {
                sh "chmod +x script.sh"
                sh "./script.sh"
                }
            }
        }
      }

    }

}
