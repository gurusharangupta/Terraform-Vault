resource "aws_instance" "web1" {
   ami           = "ami-0c2b8ca1dad447f8a"
   instance_type = "t2.micro"
   count = 1
  vpc_security_group_ids = ["sg-01718400c2741bdb3"]
   key_name               = "Linux_Terraform-Chef" 
   iam_instance_profile =   "myManagedInstanceRole"
   user_data = <<-EOF
		#!/bin/bash
                sudo mkdir /tmp/ssm
		cd /tmp/ssm
		wget https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/debian_amd64/amazon-ssm-agent.deb
		sudo dpkg -i amazon-ssm-agent.deb
		sudo systemctl enable amazon-ssm-agent
		rm amazon-ssm-agent.deb
		wget -O /tmp/chef.rpm https://packages.chef.io/files/stable/chef-workstation/20.7.96/el/7/chef-workstation-20.7.96-1.el7.x86_64.rpm
                sudo rpm -Uvh /tmp/chef.rpm
                curl -L https://omnitruck.chef.io/install.sh | sudo bash -s -- -v 15.8.23
		sudo yum update -y
       		sudo yum install git -y
       		git version
       		mkdir mygit
       		cd mygit
       		git clone https://github.com/Abishek-Ravichander/Stater_Kit.git
       		cd Stater_Kit
       		unzip chef-starter
       		mv apache-cookbook chef-repo
       		cd chef-repo
       		mv apache-cookbook cookbooks
       		cd cookbooks
	EOF

  
}
