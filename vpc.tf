resource "aws_vpc" "default" {
    cidr_block = "${var.vpc_cidr}"
    enable_dns_hostnames = true
    tags {
        Name = "Moif-aws-vpc"
    }
}

resource "aws_internet_gateway" "default" {
    vpc_id = "${aws_vpc.default.id}"
}

# This is our Moif NAT instance
resource "aws_security_group" "nat" {
    name = "Moif_vpc_nat"
    description = "Allow traffic from the private subnet to the internet"

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["${var.private_subnet_cidr}"]
    }
    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["${var.private_subnet_cidr}"]
    }
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = -1
        to_port = -1
        protocol = "icmp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    egress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["${var.vpc_cidr}"]
    }
    egress {
        from_port = -1
        to_port = -1
        protocol = "icmp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    vpc_id = "${aws_vpc.default.id}"

    tags {
        Name = "Moif_NATSG"
    }
}

resource "aws_instance" "nat" {
    ami = "ami-0a4c5a6e" # Preconfigured NAT AMI - amzn-ami-vpc-nat-hvm-2017.03.1.20170617-x86_64-ebs
    availability_zone = "eu-west-2"
    instance_type = "t2.micro"
    key_name = "${var.aws_key_name}"
    vpc_security_group_ids = ["${aws_security_group.nat.id}"]
    subnet_id = "${aws_subnet.eu-west-2-public.id}"
    associate_public_ip_address = true
    source_dest_check = false

    tags {
        Name = "Moif VPC NAT"
    }
}

resource "aws_eip" "nat" {
    instance = "${aws_instance.nat.id}"
    vpc = true
}

# The Public subnet
resource "aws_subnet" "eu-west-2-public" {
    vpc_id = "${aws_vpc.default.id}"

    cidr_block = "${var.public_subnet_cidr}"
    availability_zone = "eu-west-2"

    tags {
        Name = "Moif Public Subnet"
    }
}

resource "aws_route_table" "eu-west-2-public" {
    vpc_id = "${aws_vpc.default.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.default.id}"
    }

    tags {
        Name = "Moif Public Subnet"
    }
}

resource "aws_route_table_association" "eu-west-2-public" {
    subnet_id = "${aws_subnet.eu-west-2-public.id}"
    route_table_id = "${aws_route_table.eu-west-2-public.id}"
}


# Our Private Subnet
resource "aws_subnet" "eu-west-2-private" {
    vpc_id = "${aws_vpc.default.id}"

    cidr_block = "${var.private_subnet_cidr}"
    availability_zone = "eu-west-2"

    tags {
        Name = "Moif Private Subnet"
    }
}

resource "aws_route_table" "eu-west-2-private" {
    vpc_id = "${aws_vpc.default.id}"

    route {
        cidr_block = "0.0.0.0/0"
        instance_id = "${aws_instance.nat.id}"
    }

    tags {
        Name = "Moif Private Subnet"
    }
}

resource "aws_route_table_association" "eu-west-2-private" {
    subnet_id = "${aws_subnet.eu-west-2-private.id}"
    route_table_id = "${aws_route_table.eu-west-2-private.id}"
}
