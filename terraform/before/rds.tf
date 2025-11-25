# WASTEFUL: Multi-AZ Large DB with 2TB storage
resource "aws_db_instance" "legacy" {
  allocated_storage    = 2000 # 2TB
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.r5.4xlarge"
  multi_az             = true
  username             = "admin"
  password             = "password123" # Don't do this in prod
  skip_final_snapshot  = true
}
