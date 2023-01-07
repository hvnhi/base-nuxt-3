def image = ''

pipeline {
  agent any

  stages {
    stage ('Prepare') {
      steps {
        script {
          
        }
      }
    }

    stage('Build') {
      steps {
        script {
        }
      }
    }

    stage('Push') {
      steps {
        script {
        }
      }
    }

    stage ('Deploy') {
     steps {
        script {
        }
      }
    }
  }

  post {
    always {
      cleanWs()
    }

    success {
      sh """
        curl -s 'https://api.telegram.org/bot5507538493:AAGzGrLpWOdRGf4or45pQ_IyejjxbSd9qvk/sendMessage?chat_id=-1001008888239&parse_mode=markdown&text=*SUCCESS* %0A %0A' > /dev/null
      """
    }

    failure {
      sh """
        curl -s 'https://api.telegram.org/bot5507538493:AAGzGrLpWOdRGf4or45pQ_IyejjxbSd9qvk/sendMessage?chat_id=-1001008888239&parse_mode=markdown&text=*FAILED* %0A %0A' > /dev/null
      """
    }
  }
}