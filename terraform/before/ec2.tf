# WASTEFUL: 14 Static Instances (No ASG)
resource "aws_instance" "app_server" {
  count         = 14
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "m5.4xlarge" # $0.768/hr
  subnet_id     = element(aws_subnet.public[*].id, count.index % 3)

  tags = {
    Name = "legacy-app-server-${count.index}"
  }
}
