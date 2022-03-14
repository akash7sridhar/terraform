locals {
  name   = "Akash-EC2-TF"
  region = "ap-south-1"

  user_data = <<-EOT
  #!/bin/bash
  echo "Hello Terraform!"
  EOT

  tags = {
    Owner       = "user"
    Environment = "dev"
  }
}

################################################################################
# Supporting Resources
################################################################################

module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 4.0"

  name        = local.name
  description = "Security group for example usage with EC2 instance"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["http-80-tcp", "all-icmp"]
  egress_rules        = ["all-all"]

  tags = local.tags
}

resource "aws_placement_group" "web" {
  name     = local.name
  strategy = "cluster"
}

################################################################################
# EC2 Module
################################################################################

module "ec2_complete" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name = local.name

  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = "t2.micro"
  availability_zone           = "${local.region}a"
  subnet_id                   = element(data.terraform_remote_state.vpc.outputs.private_subnets, 0)
  vpc_security_group_ids      = [module.security_group.security_group_id]
#   placement_group             = aws_placement_group.web.id
  associate_public_ip_address = true

  # only one of these can be enabled at a time
  hibernation = true
  # enclave_options_enabled = true

  user_data_base64 = base64encode(local.user_data)

#   cpu_core_count       = 2 # default 4
#   cpu_threads_per_core = 1 # default 2

#   capacity_reservation_specification = {
#     capacity_reservation_preference = "open"
#   }

  enable_volume_tags = false
  root_block_device = [
    {
      encrypted   = true
      volume_type = "gp3"
      throughput  = 200
      volume_size = 50
      tags = {
        Name = "my-root-block"
      }
    },
  ]

  ebs_block_device = [
    {
      device_name = "/dev/sdf"
      volume_type = "gp3"
      volume_size = 5
      throughput  = 200
    }
  ]

  tags = local.tags
}