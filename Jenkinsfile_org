pipeline {
    agent {
        docker {
            image 'maven:3-alpine'
            args '-v /root/.m2:/root/.m2 -e Access_Key_Id=AKIAIR5Z5LTXISYMS7FA -e Secret_Key=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'
        }
    }
    stages {
        stage('Build') {
            steps {
                sh 'mvn -s settings.xml clean deploy'
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
