terraform {
  backend "s3" {
    bucket = "tf-state-file-akash"
    key    = "aws/vpc/"
    region = "ap-south-1"
  }
}