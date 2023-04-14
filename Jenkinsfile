pipeline {
  agent any

  tools {
    maven 'M2_HOME'
    
    }
  environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    }
  stages {
    stage('CheckOut') {
      steps {
        echo 'Checkout the source code from GitHub'
        git branch: 'main', url: 'https://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@github.com/devopscbabu/Banking-Finance-Project.git''
            }
    }
    
    stage('Package the Application') {
      steps {
        echo " Packaing the Application"
        sh 'mvn clean package'
            }
    }
    
    stage('Publish Reports using HTML') {
      steps {
      publishHTML([allowMissing: false, alwaysLinkToLastBuild: false, keepAll: false, reportDir: '/var/lib/jenkins/workspace/Insure-Project/target/surefire-reports', reportFiles: 'index.html', reportName: 'HTML Report', reportTitles: '', useWrapperFileDirectly: true])
            }
    }
    
    stage('Docker Image Creation') {
      steps {
        sh 'docker build -t cbabu85/bankingfinance:latest .'
            }
    }
    stage('DockerLogin') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'Docker-Hub', passwordVariable: 'dockerHubPassword', usernameVariable: 'dockerHubUser')]) {
        sh "docker login -u ${env.dockerHubUser} -p ${env.dockerHubPassword}"
            }
        }
    }

    stage('Push Image to DockerHub') {
      steps {
        sh 'docker push cbabu85/bankingfinance:latest'
            }
    }
        stage ('Configure Test-server with Terraform, Ansible and then Deploying'){
            steps {
                dir('my-serverfiles'){
                sh 'sudo chmod 600 keypairpem.pem'
                sh 'terraform init'
                sh 'terraform validate'
                sh 'terraform apply --auto-approve'
                }
            }
        }
     }
}
