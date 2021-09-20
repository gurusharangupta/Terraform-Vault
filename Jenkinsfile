pipeline {
environment {
        
        AWS_DEFAULT_REGION = "us-east-1"
    }
agent  any
stages {
         stage('Vault - AWS connection check') {
            steps {
              withCredentials([vaultString(credentialsId: 'AWS_ACCESS_KEY', variable: 'AWS_ACCESS_KEY_VAULT'), vaultString(credentialsId: 'AWS_SECRET_KEY', variable: 'AWS_SECRET_ACCESS_KEY_VAULT')]) {
                      sh '''
                        aws --version
                        aws ec2 describe-instances
                        '''
}
            }
        }
        stage('checkout') {
            steps {
                 script{

                        
                            git "https://github.com/gurusharangupta/Terraform-Vault.git"
                        
                    }
                }
            }
                            
        stage('Plan') {
            steps {
                     withCredentials([vaultString(credentialsId: 'AWS_ACCESS_KEY_VAULT', variable: 'AWS_ACCESS_KEY_ID'), vaultString(credentialsId: 'AWS_SECRET_ACCESS_KEY_VAULT', variable: 'AWS_SECRET_ACCESS_KEY')]) {
                bat 'cd&cd terraform/Terraform-Vault & terraform init -input=false'
                bat 'cd&cd terraform/Terraform-Vault & terraform destroy -auto-approve'
                bat "cd&cd terraform/Terraform-Vault & terraform plan -input=false -out tfplan"
                bat 'cd&cd terraform/Terraform-Vault & terraform show -no-color tfplan > tfplan.txt'
                     }
            }
        }
       

        stage('Apply') {
            steps {
                    withCredentials([vaultString(credentialsId: 'AWS_ACCESS_KEY_VAULT', variable: 'AWS_ACCESS_KEY_ID'), vaultString(credentialsId: 'AWS_SECRET_ACCESS_KEY_VAULT', variable: 'AWS_SECRET_ACCESS_KEY')]) {
                bat "cd&cd terraform/Terraform-Vault & terraform apply -input=false tfplan"
                    }
            }
        }
        
        }
   }

