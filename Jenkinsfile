pipeline {
    agent any
     
    environment {
        AWS_ACCESS_KEY_ID = credentials('jamapla-aws-key')
	AWS_SECRET_ACCESS_KEY = credentials('jamapla-aws-pass')
    }

    stages {
        stage ("Terraform init") {
            steps {
                sh "terraform init"
            }
        }

        stage ("Terraform plan") {
            when {
                not {
                    anyOf {
                        branch 'main'
                    }
                }
            }
            steps {
                sh "terraform plan"
            }
        }

        stage ("Terraform apply") {
            when {
                anyOf {
                    branch 'main'∫
                }
            }
            steps {
                sh "terraform apply --auto-approve"
            }
        }
    }


}