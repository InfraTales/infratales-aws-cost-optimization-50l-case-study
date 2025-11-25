# WASTEFUL: 8 Unattached Volumes
resource "aws_ebs_volume" "forgotten" {
  count             = 8
  availability_zone = "us-east-1a"
  size              = 100
  type              = "gp2"
  tags = {
    Name = "forgotten-volume-${count.index}"
  }
}
