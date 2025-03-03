# This code block is to initialize the terraform configuration
terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~>5.86.0"
        }
    }
}

# This code block is to configure the AWS provider 
provider "aws" {
    region = "ap-south-1"
    access_key = "AKIAZOZQFP3BT7UNH3ZN"
    secret_key = "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"
}

# This code block is to create an EBS volume
resource "aws_ebs_volume" "myfirstebsvolume" {
    availability_zone = "ap-south-1a"
    size = 5
    tags = {
      Name = "MyFirstEBCVolume-CreatedByAmit"
    }
}

# This code block is to create an EC2 instance
resource "aws_instance" "myfirstawsinstance1" {
    ami = "ami-00bb6a80f01f03502"
    instance_type = "t2.micro"
    availability_zone = "ap-south-1a"
    associate_public_ip_address = true
    tags = {
      Name = "MyFirstAWSInstance-CreatedByAmit"      
}
}

# This Code block is to create AWS VPC
resource "aws_vpc" "myfirstvpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name = "MyFirstVPC-CreatedByAmit"
    }
}

# This Code block is to create AWS Subnet
resource "aws_subnet" "myfirstsubnet" {
    vpc_id = aws_vpc.myfirstvpc.id
    cidr_block = "10.0.10.0/24"
    tags = {
      Name = "MyFirstSubnet-CreatedByAmit"
    }
}

# This Code block is to create AWS EBS Volume Attachment
resource "aws_volume_attachment" "myfirstvolumeattachment" {
    device_name = "/dev/sdf"
    volume_id = aws_ebs_volume.myfirstebsvolume.id
    instance_id = aws_instance.myfirstawsinstance1.id
}
