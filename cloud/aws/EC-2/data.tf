data "terraform_remote_state" "vpc" {
    backend = "s3"
    config = {
        bucket = "tf-state-file-akash"
        key    = "aws/vpc/"
        region = "ap-south-1"
        }
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn-ami-hvm-*-x86_64-gp2"]
  }
}