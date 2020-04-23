pipeline {
  environment {
    PROJECT = "rails-lab-260819"
    APP_NAME = "e-commerce"
    CLUSTER = "standard-cluster-2"
    CLUSTER_ZONE = "us-central1-a"
    IMAGE_TAG = "gcr.io/${PROJECT}/${APP_NAME}:${env.BUILD_ID}"
    JENKINS_CRED = "${PROJECT}"
  }

  agent {
    kubernetes {
      label 'pipeline'
      defaultContainer 'jnlp'
      yaml """
apiVersion: v1
kind: Pod
metadata:
labels:
  component: ci
spec:
  # Use service account that can deploy to all namespaces
  serviceAccountName: cd-jenkins
  containers:
  - name: gcloud
    image: gcr.io/cloud-builders/gcloud
    command:
    - cat
    tty: true
  - name: kubectl
    image: gcr.io/cloud-builders/kubectl
    command:
    - cat
    tty: true
"""
}
  }

  stages {

    stage("Checkout code") {
      steps {
        checkout scm
      }
    }
    stage('Build and push image with Container Builder') {
      steps {
        container('gcloud') {
          sh "PYTHONUNBUFFERED=1 gcloud builds submit -t ${IMAGE_TAG} ."
        } 
      }
    }
    stage('Deploy Production') {
      steps{
        container('kubectl') {
          script {
            try {
              sh 'kubectl delete job db-migrate'
            } catch (Exception e) {
            }
          }
          sh("sed -i 's#${APP_NAME}:latest#${APP_NAME}:${env.BUILD_ID}#g' ./deploy/deploy-inline.yml")
          step([$class: 'KubernetesEngineBuilder', projectId: env.PROJECT, clusterName: env.CLUSTER, zone: env.CLUSTER_ZONE, manifestPattern: 'deploy/deploy-inline.yml', credentialsId: env.JENKINS_CRED, verifyDeployments: true])
        }
      }
    }
  }
}
