pipeline {
    agent {
        docker {
            image 'maven:3-alpine'
            args '-u 994 -v /root/.m2:/root/.m2 -v /etc/passwd:/etc/passwd -v /etc/group:/etc/group -v /jenkins:/jenkins'
        }
    }
    stages {
        stage('Build') {
            steps {
                sh 'mvn clean deploy -DAWS_DEFAULT_REGION=ap-southeast-1'
            }
        }
        stage('Test') {
            steps {
                sh 'mvn test'
            }
            post {
                always {
                   // junit 'target/surefire-reports/*.xml'
                    step([$class: 'Publisher', reportFilenamePattern: '**/target/surefire-reports/testng-results.xml'])
                }
            }
        }
    }
}
