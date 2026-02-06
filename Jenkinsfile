pipeline {
  agent any

  triggers {
        pollSCM('H/2 * * * *')   // Every 2 mins
    }

  options {
    timestamps()
  }

  environment {
    TF_DIR = "infra"
  }

  stages {
    stage("Checkout") {
      steps {
        checkout scm
      }
    }

    // stage("Terraform fmt (check)") {
    //   steps {
    //     sh """
    //       cd ${TF_DIR}
    //       terraform fmt -check -diff
    //     """
    //   }
    // }

    stage("Terraform validate") {
      steps {
        sh """
          cd ${TF_DIR}
          terraform init -reconfigure
          terraform validate
        """
      }
    }

    stage("Terraform plan") {
      steps {
        sh """
          cd ${TF_DIR}
          terraform plan   -out=tfplan
          terraform show -json tfplan > tfplan.json

        """
      }
    }

    stage("Terraform apply") {
      steps {
        sh """
          cd ${TF_DIR}
          terraform apply tfplan

        """
      }
    }
  }
  // post {
  //   always {
  //     echo "Static validation completed."
  //   }
  // }
}