provider "aws" {
  region     = "us-east-1"
}

resource "aws_instance" "example_marc_terraform" {
  ami           = "ami-13be557e"
  instance_type = "t2.micro"
}

data "terraform_remote_state" "example_marc_terraform_state" {
    backend = "s3"
    config {
        bucket = "marc-meow"
        key = "terraform/terraform.tfstate"
        region = "us-east-1"
    }
}
