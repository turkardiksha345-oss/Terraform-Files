## It will store the tf.statefile in S3 bucket 

terraform {
  backend "s3" {
    bucket = "ubuntu-s3-bucket-backend"
    key    = "terraform.tfstate"
    region = "eu-north-1"           #----->> change according to the region where you S3 bucket is created
    
  }
}

provider "aws" {
    region = "eu-north-1"         #------->>  change according to the region you use
  
}

## Resource to create Instance 

resource "aws_instance" "my_instance" {
   ami = "ami-0fa91bc90632c73c9"        
   instance_type = "t3.small"
   key_name = "viju-key"
  vpc_security_group_ids = "sg-0cb3db7af0e1ddee2"
   
    tags = {
        Name = "My-instance"
        env = "dev"
    }
}
