node {
    def app

    stage('Clone repository') {

        checkout scm
    }

    stage('Build image') {
  
       app = docker.build("stemsrd/web")
    }

    stage('Test image') {
  
        app.inside {
            sh '''
                cd /fastapi-app
                export PYTHONPATH=src
                pytest
            '''
        }
    }

    stage('Push image') {
        
        docker.withRegistry('', 'dockerhub') {
            app.push("${env.BUILD_NUMBER}")
            app.push("latest")
        }
    }

    stage('Deploy') {

        sshagent(['kubernetes']) {
            sh 'scp -r -o StrictHostKeyChecking=no deployment.yaml root@16.170.225.57:/root/deployment.yaml'
            sh 'ssh root@16.170.225.57 kubectl apply -f /root/deployment.yaml'
            sh 'ssh root@16.170.225.57 kubectl rollout restart deployment.apps/webapp'
        }
    }
}
