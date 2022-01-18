#-----------
# Elastic IP
#-----------

resource "aws_eip" "ngw" {

  count = "${length(var.private_subnets)}"

  tags = merge(
    {
      "Name" = join("",["eks-eip",count.index])
    },
    var.tags
  )
  depends_on = [aws_internet_gateway.main]
}

#------------
# NAT Gateway
#------------

resource "aws_nat_gateway" "this" {
  
  count = "${length(var.private_subnets)}"
  
  allocation_id = aws_eip.ngw.*.id[count.index]
  
  subnet_id = aws_subnet.private.*.id[count.index]
  
  tags = merge(
    {
      "Name" = join("",["eks-ngw",count.index])
    },
    var.tags
  )
}