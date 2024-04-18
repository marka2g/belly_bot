packer {
  required_plugins {
    amazon = {
      version = ">= 1.3.2"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "base" {
  ami_regions = var.ami_regions
  // source_ami = "YOUR_AMI_ID"
  // source_ami = "ami-0d421d84814b7d51c"
  source_ami_filter {
    filters = {
      name = "al2023-ami-2023*" 
      architecture = "x86_64"
    }
    most_recent = true 
    owners = ["amazon"]
  }
  instance_type = "t2.micro"
  ssh_username = "ec2-user"
  ami_name = "amazon-linux-docker_{{timestamp}}"
}

build {
  sources = ["source.amazon-ebs.base"]
  provisioner "shell" { 
    // inline = [
    //   "sudo dnf update -y",
    //   "sudo dnf install -y docker",
    //   "sudo systemctl start docker",
    //   "sudo systemctl enable docker",
    //   "sudo usermod -a -G docker ec2-user", "sudo dnf install -y nmap"
    // ] 
    script = "setup.sh"
    # run script after cloud-init finishes to avoid race conditions 
    execute_command = "cloud-init status --wait && sudo -E sh '{{ .Path }}'"
  }
}
