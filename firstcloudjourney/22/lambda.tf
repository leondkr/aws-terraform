module "lambda_auto_start" {
  source = "terraform-aws-modules/lambda/aws"

  function_name = "dc-common-lambda-auto-start"
  description   = "My awesome lambda function"
  handler       = "index.lambda_handler"
  runtime       = "python3.9"

  source_path = "./src/lambda-start"

  environment_variables = {
    environment_auto  = "true"
    slack_webhook_url = var.slack_webhook_url
  }

  attach_policies    = true
  number_of_policies = 2
  policies = [
    "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole",
    "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
  ]

  allowed_triggers = {
    EventAutoStartRule = {
      principal  = "events.amazonaws.com"
      source_arn = module.eb_rules.eventbridge_rule_arns["crons-auto-start"]
    }
  }

  tags = {
    Terraform = "true"
    Name      = "dc-common-lambda-auto-start"
  }
}

module "lambda_auto_stop" {
  source = "terraform-aws-modules/lambda/aws"

  function_name = "dc-common-lambda-auto-stop"
  description   = "My awesome lambda function"
  handler       = "index.lambda_handler"
  runtime       = "python3.9"

  source_path = "./src/lambda-stop"

  environment_variables = {
    environment_auto  = "true"
    slack_webhook_url = var.slack_webhook_url
  }

  attach_policies    = true
  number_of_policies = 2
  policies = [
    "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole",
    "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
  ]

  allowed_triggers = {
    EventAutoStopRule = {
      principal  = "events.amazonaws.com"
      source_arn = module.eb_rules.eventbridge_rule_arns["crons-auto-stop"]
    }
  }

  tags = {
    Terraform = "true"
    Name      = "dc-common-lambda-auto-stop"
  }
}


