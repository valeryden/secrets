packer {
  required_plugins {
    amazon = {
      version = ">= 1.5.0"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

variable "aws_region" {
  type = string
  default = "us-east-1"
}

source "amazon-ebs" "example" {
  ami_name      = "example-ami"
  instance_type = "t2.micro"
  region        = var.aws_region
  source_ami_filter {
    filters = {
      virtualization-type = "hvm"
      root-device-type    = "ebs"
    }
    most_recent = true
    owners = ["amazon"]
  }
}

build {
  sources = ["source.amazon-ebs.example"]

  provisioner "shell" {
    inline = [
      "sudo choco upgrade pwsh -y --no-progress",  # No version pinned
      "sudo choco upgrade git -y --no-progress",   # No version pinned
      "sudo choco upgrade nodejs -y --no-progress",# No version pinned
      "sudo choco upgrade winrar -y --no-progress",  # No version pinned
      "sudo choco upgrade edge -y --no-progress",   # No version pinned
      "sudo choco upgrade excel -y --no-progress"   # No version pinned
    ]
  }
}
