data "terraform_remote_state" "vpc" {
    backend = "s3"
    config = {
        bucket = "tf-state-file-akash"
        key    = "aws/vpc/"
        region = "ap-south-1"
        }
}
