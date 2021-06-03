provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

locals {
  name        = "conan"
  environment = terraform.workspace

  # This is the convention we use to know what belongs to each other
  resource_name = "${local.name}-${local.environment}"
}
