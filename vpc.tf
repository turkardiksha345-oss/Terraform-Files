provider "aws" {
  region = "eu-north-1"
}

#VPC Creation Block

resource "aws_vpc" "my_vpc" {
    cidr_block = "10.0.0.0/16"
    instance_tenancy = "default"

    tags = {
      env = "dev"
      name = "my-vpc"
    }
  
}

#Public Subnet

resource "aws_subnet" "my_public_subnet" {
    vpc_id = aws_vpc.my_vpc.id 
    cidr_block = "10.0.0.0/17"
    
    tags = {
      env = "dev"
      name = "Public-subnet"
    }
  
}


#Private Subnet

resource "aws_subnet" "my_private_subnet" {
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = "10.0.128.0/17"
  tags = {
    env = "dev"
    name = "Private-subnet"
  }
}

#Internet Gateway

resource "aws_internet_gateway" "my-igw" {
    vpc_id = aws_vpc.my_vpc.id

    tags = {
      env = "dev"
      name = "my-igw"
    }
  
}

#Public Route Table

resource "aws_route_table" "public_rt" {
    vpc_id = aws_vpc.my_vpc.id

    tags = {
      env = "dev"
      name = "public-rt"
    }
  
}

# Route Table Association

resource "aws_route_table_association" "public_association" {
    subnet_id = aws_subnet.my_public_subnet.id 
    route_table_id = aws_route_table.public_rt.id
  
}

