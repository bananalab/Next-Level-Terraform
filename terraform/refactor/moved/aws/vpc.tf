module "vpc" {
  source = "github.com/bananalab/terraform-modules//modules/aws-vpc"
  cidr = var.vpc_cidr
  availability_zones = var.availability_zones
  public_subnets = var.public_subnet_cidrs
  private_subnets = var.private_subnet_cidrs
}

/*
resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr
}
*/

moved {
  from = aws_vpc.this
  to = module.vpc.aws_vpc.this
}

/*
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
}
*/

moved {
  from = aws_internet_gateway.this
  to = module.vpc.aws_internet_gateway.this
}

/*
# Public subnet config
locals {
  public_subnets = zipmap(var.availability_zones, var.public_subnet_cidrs)
}

resource "aws_subnet" "public" {
  for_each          = local.public_subnets
  vpc_id            = aws_vpc.this.id
  cidr_block        = each.value
  availability_zone = each.key
  map_public_ip_on_launch = true
}
*/

moved {
  from = aws_subnet.public
  to = module.vpc.aws_subnet.public
}

/*
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id
}
*/

moved {
  from = aws_route_table.public
  to = module.vpc.aws_route_table.public
}

/*
resource "aws_route" "public" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id
}
*/

moved {
  from = aws_route.public
  to = module.vpc.aws_route.public
}

/*
resource "aws_route_table_association" "public" {
  for_each       = aws_subnet.public
  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}
*/

moved {
  from = aws_route_table_association.public
  to = module.vpc.aws_route_table_association.public
}

/*
resource "aws_nat_gateway" "this" {
  for_each      = aws_subnet.public
  allocation_id = aws_eip.nat[each.key].id
  subnet_id     = each.value.id
  depends_on    = [aws_internet_gateway.this]
}
*/

moved {
  from = aws_nat_gateway.this
  to = module.vpc.aws_nat_gateway.this
}

/*
resource "aws_eip" "nat" {
  for_each = aws_subnet.public
  vpc      = true
}
*/

moved {
  from = aws_eip.nat
  to = module.vpc.aws_eip.nat
}

/*
# Private subnet config
locals {
  private_subnets = zipmap(var.availability_zones, var.private_subnet_cidrs)
}

resource "aws_subnet" "private" {
  for_each          = local.private_subnets
  vpc_id            = aws_vpc.this.id
  cidr_block        = each.value
  availability_zone = each.key
}
*/

moved {
  from = aws_subnet.private
  to = module.vpc.aws_subnet.private
}

/*
resource "aws_route_table" "private" {
  for_each = aws_subnet.private
  vpc_id   = aws_vpc.this.id
}
*/

moved {
  from = aws_route_table.private
  to = module.vpc.aws_route_table.private
}

/*
resource "aws_route" "private" {
  for_each               = aws_route_table.private
  route_table_id         = each.value.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.this[each.key].id
}
*/

moved {
  from = aws_route.private
  to = module.vpc.aws_route.private
}

/*
resource "aws_route_table_association" "private" {
  for_each       = aws_route.private
  subnet_id      = aws_subnet.private[each.key].id
  route_table_id = aws_route_table.private[each.key].id
}
*/

moved {
  from = aws_route_table_association.private
  to = module.vpc.aws_route_table_association.private
}