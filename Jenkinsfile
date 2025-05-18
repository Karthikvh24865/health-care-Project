pipeline {
  agent any
   environment {
         AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
         AWS_SECRET_ACCESS_KEY = credentials('AWS_ACCESS_KEY_ID') 
   } 
  stages {
   stage('CheckOut') {
      steps {
        echo 'Checkout the source code from GitHub'
        git 'https://github.com/Karthikvh24865/health-care-Project.git'
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
      publishHTML([allowMissing: false, alwaysLinkToLastBuild: false, keepAll: false, reportDir: '/var/lib/jenkins/workspace/HealtcareProject/target/surefire-reports', reportFiles: 'index.html', reportName: 'HTML Report', reportTitles: '', useWrapperFileDirectly: true])
            }
    }
    
    stage('Docker Image Creation') {
      steps {
        sh 'sudo docker build -t karthikhiremath/healthcare:1.0 .'
            }
    }
    stage('DockerLogin') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'DockerLogin', passwordVariable: 'docker_password', usernameVariable: 'docker_login')]) {
        sh "sudo docker login -u ${docker_login} -p ${docker_password}"
            }
        }
    } 
  
    stage('Push Image to DockerHub') {
      steps {
        sh 'sudo docker push karthikhiremath/healthcare:1.0'
            }
    } 
        stage ('Configure Kubernetes-server with Terraform'){
            steps {
                //dir('my-serverfiles'){
                sh 'sudo chmod 600 huli.pem'
                sh 'terraform init'
                sh 'terraform validate'
                sh 'terraform apply --auto-approve'
                }
            }
        
       /* stage ('Deploy into Kubernetes-server using Ansible') {
           steps {
             ansiblePlaybook credentialsId: 'sshkey', disableHostKeyChecking: true, installation: 'ansible', inventory: '/etc/ansible/hosts', playbook: 'ansible-playbook.yml', vaultTmpPath: '' 
           }
               }
               */
     }
}
