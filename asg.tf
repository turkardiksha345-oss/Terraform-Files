## Launch template

resource "aws_launch_template" "my_template" {
  name_prefix = "my-template"
  image_id    = "ami-0fa91bc90632c73c9"    
  instance_type = "t3.micro"
  key_name      = "viju-key"                 
  vpc_security_group_ids = ["sg-09040ae4cd8504987"]

  user_data = base64encode(<<EOF
#!/bin/bash
sudo apt update -y
sudo apt install nginx -y
echo "<h1>Hello World from ASG + ALB</h1>" > /var/www/html/index.html
EOF
  )

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "example-asg-instance"
    }
  }
}

#Autoscaling group

resource "aws_autoscaling_group" "my_asg" {
  name = "my-autoscaling-group"

  launch_template {
    id      = aws_launch_template.my_template.id
    version = "$Latest"
  }

  min_size         = 1
  max_size         = 3
  desired_capacity = 2

  vpc_zone_identifier = [
    "subnet-0e40e13af310eb0f0",
    "subnet-0bd2a6db82585a589"
  ]

  target_group_arns = [aws_lb_target_group.my_tg.arn]

  tag {
    key                 = "Name"
    value               = "example-asg"
    propagate_at_launch = true
  }
}

