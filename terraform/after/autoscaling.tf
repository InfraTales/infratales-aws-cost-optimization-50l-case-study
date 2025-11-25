# OPTIMIZED: ASG with Mixed Instances (Spot + On-Demand)
resource "aws_launch_template" "app" {
  name_prefix   = "optimized-lt-"
  image_id      = "ami-0c55b159cbfafe1f0"
  instance_type = "t3.medium" # Rightsized from m5.4xlarge
}

resource "aws_autoscaling_group" "app" {
  name                = "optimized-asg"
  vpc_zone_identifier = aws_subnet.public[*].id
  max_size            = 10
  min_size            = 2
  desired_capacity    = 2

  mixed_instances_policy {
    instances_distribution {
      on_demand_base_capacity                  = 1
      on_demand_percentage_above_base_capacity = 20 # 80% Spot
      spot_allocation_strategy                 = "capacity-optimized"
    }
    launch_template {
      launch_template_specification {
        launch_template_id = aws_launch_template.app.id
        version            = "$Latest"
      }
    }
  }
}
