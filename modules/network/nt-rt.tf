#--------------
# Publiс routes
#--------------

resource "aws_route_table" "public" {

  count = "${length(var.public_subnets)}"
  
  vpc_id = var.vpc_id

  route {
    
    cidr_block = "0.0.0.0/0"

    gateway_id = aws_internet_gateway.main.id
  }

  tags = merge(
    {
      "Name" = join("",["rt-public",count.index])
    },
    var.tags
  )
}

#resource "aws_route" "public_internet_gateway" {
  
#  count = "${length(var.public_subnets)}"
  
#  route_table_id = aws_route_table.public[count.index].id
  
#  destination_cidr_block = "0.0.0.0/0"
  
#  gateway_id = aws_internet_gateway.main.id

#  timeouts {
#      create = "5m"
#  }
#}

#---------------
# Private routes
#---------------

resource "aws_route_table" "private" {
  
  count = "${length(var.private_subnets)}"
  
  vpc_id = var.vpc_id

  route {
    
    cidr_block = "0.0.0.0/0"

    nat_gateway_id = aws_nat_gateway.this[count.index].id
  }

  tags = merge(
    {
      "Name" = join("",["rt-private",count.index])
    },
    var.tags
  )
}

#resource "aws_route" "private_nat_gateway" {
  
#  count = "${length(var.private_subnets)}"
  
#  route_table_id = aws_route_table.private[count.index].id
  
#  destination_cidr_block = "0.0.0.0/0"
  
#  nat_gateway_id = aws_nat_gateway.this[0].id

#  timeouts {
#    create = "5m"
#  }
#}

#------------------------
# Route table association
#------------------------

resource "aws_route_table_association" "public" {
  
  count = "${length(var.public_subnets)}"
  
  subnet_id = aws_subnet.public.*.id[count.index]
  
  route_table_id = aws_route_table.public.*.id[count.index]
}

resource "aws_route_table_association" "private" {
  
  count = "${length(var.private_subnets)}"
  
  subnet_id = aws_subnet.private.*.id[count.index]
  
  route_table_id = aws_route_table.private.*.id[count.index]
}