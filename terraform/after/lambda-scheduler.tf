# OPTIMIZED: Lambda to stop Dev instances at night
resource "aws_lambda_function" "scheduler" {
  filename      = "scheduler.zip"
  function_name = "InstanceScheduler"
  role          = aws_iam_role.lambda.arn
  handler       = "index.handler"
  runtime       = "python3.9"
}

resource "aws_iam_role" "lambda" {
  name = "scheduler_role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = { Service = "lambda.amazonaws.com" }
    }]
  })
}
