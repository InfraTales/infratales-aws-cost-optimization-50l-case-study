# OPTIMIZED: Rightsized DB with Storage Autoscaling
resource "aws_db_instance" "optimized" {
  allocated_storage     = 50 # Rightsized from 2000
  max_allocated_storage = 1000 # Autoscaling enabled
  storage_type          = "gp3"
  engine                = "mysql"
  engine_version        = "8.0"
  instance_class        = "db.t3.medium" # Rightsized from r5.4xlarge
  multi_az              = true
  username              = "admin"
  password              = "securepassword123"
  skip_final_snapshot   = true
  
  # Backup retention optimized
  backup_retention_period = 7
}
