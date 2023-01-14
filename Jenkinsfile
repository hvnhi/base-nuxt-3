def image = ''

pipeline {
  agent any
  stages {
    stage('Clone') {
      steps{
        git 'https://github.com/hvnhi/base-nuxt-3.git'
      }
    }
  }
  post {
    always {
      cleanWs()
    }

    success {
      sh """
        curl -s 'https://api.telegram.org/bot5507538493:AAGzGrLpWOdRGf4or45pQ_IyejjxbSd9qvk/sendMessage?chat_id=-706657691&parse_mode=markdown&text=*SUCCESS* %0A %0A' > /dev/null
      """
    }

    failure {
      sh """
        curl -s 'https://api.telegram.org/bot5507538493:AAGzGrLpWOdRGf4or45pQ_IyejjxbSd9qvk/sendMessage?chat_id=-706657691&parse_mode=markdown&text=*FAILURE* %0A %0A' > /dev/null
      """
    }
  }
}