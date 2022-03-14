terraform {
  backend "s3" {
    bucket = "tf-state-file-akash"
    key    = "aws/eks"
    region = "ap-south-1"
  }
}