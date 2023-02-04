def image = ''

pipeline {
  agent any

  stages {
    stage('Prepare') {
      steps{
        script {
          def AUTHOR = ""
          def COMMIT_MSG = ""
          def BRANCH_NAME = "master"
          def APP_NAME = "Develop"
          def changeFolders = []

          def changeLogSets = currentBuild.changeSets
          for (int i = 0; i < changeLogSets.size(); i++) {
            def entries = changeLogSets[i].items
            for (int j = 0; j < entries.length; j++) {
              def entry = entries[j]
              echo "${entry.commitId} by ${entry.author} on ${new Date(entry.timestamp)}: ${entry.msg}"
              
              AUTHOR = entry.author
              COMMIT_MSG += " %0A - ${entry.msg} "
            }
          }
          env.APP_NAME = APP_NAME
          env.BRANCH_NAME = BRANCH_NAME
          env.AUTHOR = AUTHOR
          env.COMMIT_MSG = COMMIT_MSG
          env.IMAGE_NAME = "hvnhi/dev"
        }
      }
    }

    stage('Build') {
      steps {
        script {
          image = docker.build("${env.IMAGE_NAME}", "-f Dockerfile .")
        }
      }
    }

    stage('Deploy') {
      steps {
        script {
            sh 'docker stop $( docker ps -a -q --filter="name=hvnhi_web")'
            sh 'docker rm $( docker ps -a -q --filter="name=hvnhi_web")'
            sh 'docker run -dp 3000:3000 --name hvnhi_web hvnhi/dev'
        }
      }
    }
    
    // stage('Push') {
    //   steps {
    //     script {
    //       // This step should not normally be used in your script. Consult the inline help for details.
    //       withDockerRegistry(credentialsId: 'docker-hub-token', url: 'https://index.docker.io/v1/') {
    //           image.push()
    //       }
    //     }
    //   }
    // }

    // stage('Deploy to k8s') {
    //   steps {
    //       script {
    //           kubernetesDeploy (configs: 'deployment.dev.yaml',kubeconfigId: 'k8s')
    //       }
    //   }
    // }
  }
    
  post {
    // always {
    //   cleanWs()
    // }

    success {
      sh """
        curl -s 'https://api.telegram.org/bot5507538493:AAGzGrLpWOdRGf4or45pQ_IyejjxbSd9qvk/sendMessage?chat_id=-706657691&parse_mode=markdown&text=*SUCCESS* %0A %0A *${env.APP_NAME}* %0A %0A Branch: ${env.BRANCH_NAME} %0A %0A Author: ${env.AUTHOR} %0A %0A Message: ${env.COMMIT_MSG}' > /dev/null
      """
    }

    failure {
      sh """
        curl -s 'https://api.telegram.org/bot5507538493:AAGzGrLpWOdRGf4or45pQ_IyejjxbSd9qvk/sendMessage?chat_id=-706657691&parse_mode=markdown&text=*FAILED* %0A %0A *${env.APP_NAME}* %0A %0A Branch: ${env.BRANCH_NAME} %0A %0A Author: ${env.AUTHOR}' > /dev/null
      """
    }
  }
}