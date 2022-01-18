#--------------
# Public subnet
#--------------

resource "aws_subnet" "public" {
  
  count = "${length(var.public_subnets)}"
  
  vpc_id = var.vpc_id
  
  cidr_block = var.public_subnets[count.index]
  
  availability_zone = var.availability_zone_names[count.index]
  
  map_public_ip_on_launch = true

  tags = merge(
    {
      "Name" = join("",["sn",count.index])
    },
    var.pub_sn_tags
  )
}

#---------------
# Private subnet
#---------------

resource "aws_subnet" "private" {
  
  count = "${length(var.private_subnets)}"
  
  vpc_id = var.vpc_id
  
  cidr_block = var.private_subnets[count.index]
  
  availability_zone = var.availability_zone_names[count.index]

  tags = merge(
    {
      "Name" = join("",["sn",count.index])
    },
    var.prv_sn_tags
  )
}