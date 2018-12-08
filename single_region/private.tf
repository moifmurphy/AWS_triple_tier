# Database Servers
resource "aws_security_group" "db" {
  provider    = "aws.singleregion"
  name        = "Moif_vpc_db"
  description = "Allow incoming connections."

  ingress {
    from_port       = 1433                             # SQL Server Default Port
    to_port         = 1433
    protocol        = "tcp"
    security_groups = ["${aws_security_group.web.id}"]
  }

  ingress {
    from_port       = 3306                             # MySQL Default Port
    to_port         = 3306
    protocol        = "tcp"
    security_groups = ["${aws_security_group.web.id}"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${var.vpc_cidr}"]
  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["${var.vpc_cidr}"]
  }

  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = "${aws_vpc.default.id}"

  tags {
    Name = "Moif_DB_Servers_SG"
  }
}

resource "aws_instance" "db-1" {
  provider               = "aws.singleregion"
  ami                    = "${lookup(var.amis, var.aws_region)}"
  availability_zone      = "eu-west-2"
  instance_type          = "t2.micro"
  key_name               = "${var.aws_key_name}"
  vpc_security_group_ids = ["${aws_security_group.db.id}"]
  subnet_id              = "${aws_subnet.eu-west-2-private.id}"
  source_dest_check      = false

  tags {
    Name = "Moif Database Server"
  }
}
