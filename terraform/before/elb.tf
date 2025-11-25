# WASTEFUL: 3 Unused Load Balancers
resource "aws_lb" "unused" {
  count              = 3
  name               = "legacy-unused-alb-${count.index}"
  internal           = false
  load_balancer_type = "application"
  subnets            = aws_subnet.public[*].id
}
