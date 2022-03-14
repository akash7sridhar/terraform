terraform {
  backend "s3" {
    bucket = "tf-state-file-akash"
    key    = "aws/ec-2"
    region = "ap-south-1"
  }
}