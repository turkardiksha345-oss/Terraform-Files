provider "aws" {
  region = "eu-north-1"
}

resource "aws_instance" "my_instance" {
  
  ami  = "ami-0fa91bc90632c73c9"
  instance_type = "t3.micro"
  vpc_security_group_ids = [aws_security_group.aws_sg.id]

 user_data = <<-EOF
#!/bin/bash
sudo apt update -y
sudo apt install nginx -y
echo "<h1> hello pranit </h1>" > /var/www/html/index.html
sudo systemctl start nginx
sudo systemctl enable nginx
EOF
 

  tags = {
    env = "dev"
    Name = "my_tf_instance"
     
  }
}

resource "aws_security_group" "aws_sg" {     # to create security group
  name        = "sg_name"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = "vpc-0fed28ece99ad2aa5"

    ingress {                               # inbound rule
    from_port   = 80  
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    }

    egress {                               # outbound rule
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    }
  
    tags = {
    env = "dev" 
  }
}
