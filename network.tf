module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 2.0"

  name = local.resource_name

  cidr = "10.1.0.0/16"

  azs             = ["us-east-1a"]
  private_subnets = []
  public_subnets  = ["10.1.11.0/24"]

  enable_nat_gateway = false

  tags = {
    Name        = local.name
    Environment = local.environment
  }
}