# Creación de una instancia EC2 usando la AMI obtenida
resource "aws_instance" "pruebafinal" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  key_name      = var.key_name
  tags = {
    Name = var.instance_name
  }

  associate_public_ip_address = true

  security_groups = [var.sg_id]

}
resource "aws_cloudwatch_metric_alarm" "high_cpu_alarm" {
  alarm_name                = "high-cpu-utilization"
  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = "1"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = "300"
  statistic                 = "Average"
  threshold                 = "80"
  dimensions = {
    InstanceId = aws_instance.pruebafinal.id
  }
  alarm_description         = "Alarm when EC2 CPU utilization exceeds 80%"
  insufficient_data_actions = []
  ok_actions                = []
  alarm_actions             = [
    aws_sns_topic.high_cpu_alert.arn  # SNS Topic ARN to send notifications
  ]
}


# Create an SNS Topic
resource "aws_sns_topic" "high_cpu_alert" {
  name = "high-cpu-alerts"
}

# Create an SNS Subscription (e.g., send an email)
resource "aws_sns_topic_subscription" "high_cpu_email" {
  topic_arn = aws_sns_topic.high_cpu_alert.arn
  protocol  = "email"
  endpoint  = "cpobletev11@gmail.com"  # Replace with your email
}
#Lambda function
resource "aws_lambda_function" "process_sns_message" {
  filename         = "lambda_function_payload.zip"  
  function_name    = "ProcessSnsMessage"
  role             = aws_iam_role.lambda_execution_role.arn
  handler          = "index.handler"
  runtime          = "nodejs16.x"

  environment {
    variables = {
      SNS_TOPIC_ARN = aws_sns_topic.high_cpu_alert.arn
    }
  }
}
#lambda exec
resource "aws_iam_role" "lambda_execution_role" {
  name = "lambda_execution_role"
  
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action    = "sts:AssumeRole"
        Effect    = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy_attachment" "lambda_policy_attachment" {
  name       = "lambda_policy_attachment"
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  roles      = [aws_iam_role.lambda_execution_role.name]
}

#lambda x sns
resource "aws_sns_topic_subscription" "lambda_subscription" {
  topic_arn = aws_sns_topic.high_cpu_alert.arn
  protocol  = "lambda"
  endpoint  = aws_lambda_function.process_sns_message.arn
}
#sqs lambda
resource "aws_sqs_queue" "lambda_queue" {
  name = "lambda-sqs-queue"
}

# Add permissions for Lambda to access SQS
resource "aws_lambda_permission" "allow_sns_to_trigger_lambda" {
  statement_id  = "AllowExecutionFromSNS"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.process_sns_message.function_name
  principal     = "sns.amazonaws.com"
  source_arn    = aws_sns_topic.high_cpu_alert.arn
}
