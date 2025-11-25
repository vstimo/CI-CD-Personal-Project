resource "aws_vpc" "main_vpc" {
    cidr_block = var.vpc_cidr

    tags = {
        Name = "${var.project}-vpc"
    }
}

resource "aws_internet_gateway" "igw" {
    vpc_id          = aws_vpc.main_vpc.id

    tags = {
        Name = "${var.project}-igw"
    }
}

resource "aws_subnet" "public_subnets" {
    count = length(var.public_subnet_cidr)
    vpc_id = aws_vpc.main_vpc.id
    cidr_block = var.public_subnet_cidr[count.index]
    availability_zone = var.availability_zones[count.index]
    map_public_ip_on_launch = true

    tags = {
        Name = "${var.project}-public-subnet"
    }
}

resource "aws_route_table" "public_rt" {
    vpc_id = aws_vpc.main_vpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }

    tags = {
        Name = "${var.project}-route-table"
    }
}

resource "aws_route_table_association" "public_rt_assoc" {
  count          = length(aws_subnet.public_subnets)
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.public_rt.id
}