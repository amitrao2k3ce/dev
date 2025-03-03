terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws"
            version = "~>5.86.0"
        }
    }
}

provider "aws" {
    region = "ap-south-1"
    access_key = "AKIAZOZQFP3BT7UNH3ZN"
    secret_key = "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"
}

resource "aws_ebs_volume" "myfirstebsvolume" {
    availability_zone = "ap-south-1a"
    size = 5
    tags = {
      Name = "MyFirstEBCVolume-CreatedByAmit"
    }
}

resource "aws_instance" "myfirstawsinstance1" {
    ami = "ami-00bb6a80f01f03502"
    instance_type = "t2.micro"
    availability_zone = "ap-south-1a"
    associate_public_ip_address = true
    tags = {
      Name = "MyFirstAWSInstance-CreatedByAmit"      
}

}

resource "aws_vpc" "myfirstvpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name = "MyFirstVPC-CreatedByAmit"
    }
}

resource "aws_subnet" "myfirstsubnet" {
    vpc_id = aws_vpc.myfirstvpc.id
    cidr_block = "10.0.10.0/24"
    tags = {
      Name = "MyFirstSubnet-CreatedByAmit"
    }
}

resource "aws_volume_attachment" "myfirstvolumeattachment" {
    device_name = "/dev/sdf"
    volume_id = aws_ebs_volume.myfirstebsvolume.id
    instance_id = aws_instance.myfirstawsinstance1.id
}
