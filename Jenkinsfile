#!groovy
pipeline {
  options {
    buildDiscarder(logRotator(numToKeepStr: '10'))
    disableConcurrentBuilds()
  }
  agent any
  stages {
    stage('Build') {
      steps {
          catchError {
          sh '''
            SBI/build.sh
          '''
          }
      }
    post {
            success {
                echo 'Build stage successful'
            }
            failure {
                echo 'Compile stage failed'
                error('Build is aborted due to failure of build stage')
         }
     }
   }
    stage('Test') {
      steps {
        catchError {
          sh '''
            SBI/test.sh
          '''
        }
      }
  post {
        success {
              echo 'Test stage successful'
            }
            failure {
               echo 'Test stage failed'
              error('Test is aborted due to failure of Test stage')

        }
    }
  }
  stage('Container Build') {
  steps {
        catchError {
          sh '''
            SBI/dockerize.sh
          '''
        }
      }
     post {
            success {
                echo 'Docker image build stage successful'
            }
            failure {
                echo 'Docker image build stage failed'
                error('Docker build is aborted due to failure of dockerize stage')

             }
         }
    }
  }
  post {
    always {
      script {
        currentBuild.result = currentBuild.currentResult
        sh '''
        [ -f build_fail.log ] && tail -50 build_fail.log  >> build_fail.txt && rm -f build_fail.log && mv build_fail.txt build_fail.log && \
        rm -f build_fail.log-txt* && \
        unix2dos build_fail.log
        '''
      }
    }
    fixed {
      emailext (attachLog: true, body: "${currentBuild.result}: ${BUILD_URL}", //compressLog: true, 
                subject: "Jenkins build back to normal: ${currentBuild.fullDisplayName}", 
              //  recipientProviders: [[$class: 'CulpritsRecipientProvider'],[$class: 'RequesterRecipientProvider']],
                to: 'smandal@rythmos.com')
    }
    failure {
        emailext (attachmentsPattern: 'build_fail.log',
                body: "${currentBuild.result}: ${BUILD_URL}", //compressLog: true, 
                subject: "Build failed in Jenkins: ${currentBuild.fullDisplayName}", 
              //  recipientProviders: [[$class: 'CulpritsRecipientProvider'],[$class: 'RequesterRecipientProvider']],
              to: 'smandal@rythmos.com')
    }
    unstable {
      // notify users when the Pipeline unstable
      emailext (attachLog: true, body: "${currentBuild.result}: ${BUILD_URL}", //compressLog: true, 
                subject: "Unstable Pipeline: ${currentBuild.fullDisplayName}", 
               // recipientProviders: [[$class: 'CulpritsRecipientProvider'],[$class: 'RequesterRecipientProvider']],
                to: 'smandal@rythmos.com')
    }
  }
  }
