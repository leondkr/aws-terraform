module "bastion" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "3.5.0"

  name = "lambda-lab-instance"

  ami                         = "ami-0bd6906508e74f692"
  instance_type               = "t2.micro"
  key_name                    = var.ec2_key_pair_name
  monitoring                  = false
  vpc_security_group_ids      = [module.bastion_sg.security_group_id]
  associate_public_ip_address = true
  # user_data                   = file("user-data/bastion.sh")

  subnet_id = var.vpc_subnet_id

  root_block_device = [
    {
      volume_type = "gp3"
      volume_size = 10
    },
  ]

  tags = {
    # Terraform = "true"
    Name             = "lambda-lab-instance"
    Environment_Auto = "true"
  }
}

##################################################################
# AWS SG
##################################################################

module "bastion_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "lambda-lab-instance-sg"
  description = "Security group for bastion usage with EC2 instance"

  vpc_id              = var.vpc_id
  ingress_cidr_blocks = ["0.0.0.0/0"]
  ingress_rules       = ["ssh-tcp", "all-icmp"]
  egress_rules        = ["all-all"]
}

##################################################################
# OUTPUT
##################################################################

output "bastion_host_public_ip" {
  value = module.bastion.public_ip
}
