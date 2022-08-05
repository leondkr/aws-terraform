module "eb_rules" {
  source  = "terraform-aws-modules/eventbridge/aws"
  version = "1.14.2"

  create_bus = false

  rules = {
    crons-auto-start = {
      description         = "Trigger for an auto-start Lambda"
      schedule_expression = "rate(8 hours)"
    }
    crons-auto-stop = {
      description         = "Trigger for an auto-stop Lambda"
      schedule_expression = "rate(9 hours)"
    }
  }

  targets = {
    crons-auto-start = [
      {
        name = "dc-common-lambda-auto-start"
        arn  = module.lambda_auto_start.lambda_function_arn
        # input = jsonencode({ "job" : "cron-by-rate" })
      }
    ]
    crons-auto-stop = [
      {
        name = "dc-common-lambda-auto-stop"
        arn  = module.lambda_auto_stop.lambda_function_arn
        # input = jsonencode({ "job" : "cron-by-rate" })
      }
    ]
  }

  lambda_target_arns = [
    module.lambda_auto_start.lambda_function_arn,
    module.lambda_auto_stop.lambda_function_arn,
  ]

  create_role          = false
  attach_lambda_policy = true
}
