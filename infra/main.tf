provider "aws" {
  region = "us-west-2"
}

data "aws_secretsmanager_secret_version" "api" {
  secret_id = "lab/user06/api/key" 
}

resource "aws_instance" "secure_app" {
  ami           = "ami-055a9df0c8c9f681c"
  instance_type = "t3.micro"

  user_data = templatefile("userdata.sh", {
    api_key = data.aws_secretsmanager_secret_version.api.secret_string
  })

  tags = {
    Name = "Secure-App-Server"
  }
}
