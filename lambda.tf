provider "aws" {
  region = var.region 
}
/*
data "archive_file" "lambda" {
  type        = "zip"
  source_file = "${path.module}/python/lambda_dynamo/lambda_dynamo.py"
  output_path = "${path.module}/python/lambda_dynamo/lambda_dynamo.zip"
}
*/
resource "aws_lambda_function" "test_lambda" {
  count = var.create-function ? 1 : 0
  function_name = "${var.environment}-${var.lambda_name}"
  filename      = var.package_filename #data.archive_file.lambda.output_path
  role          = var.create_role ? aws_iam_role.lambda[0].arn : var.lambda_role
  handler       = var.lambda_handler
  source_code_hash = filebase64sha256(var.package_filename)
  runtime = var.runtime
  # environment {
  #   variables = {
  #     TABLE_NAME = var.dynamodb_id
  #   }
  # }
  tags = var.tags
}
resource "aws_iam_role" "lambda" {
  count = var.create_role ? 1 : 0
  #function_name = aws_lambda_function.test_lambda[0].arn
  name = "iam_for_lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "policy" {
  name = "lambda_policy"
  role = aws_iam_role.lambda[0].id

  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : [
          "sqs:*",
        ],
        "Effect" : "Allow",
        "Resource" : "*"
      },
      {
        "Action" : [
          "sns:*",
        ],
        "Effect" : "Allow",
        "Resource" : "*"
      },
      {
        "Action" : [
          "logs:*", 
        ],
        "Effect" : "Allow",
        "Resource" : "*"
      },
      {
        "Action" : [
          "dynamodb:*", 
        ],
        "Effect" : "Allow",
        "Resource" : "*"
      }
    ]
  })

}
resource "aws_lambda_function_event_invoke_config" "example" {
  count = var.create-event-invoke ? 1 : 0
  function_name = var.lambda_arn
  destination_config {
    on_failure {
      destination = var.sns_arn
    }

    on_success {
      destination = var.sns_arn
    }
    }
}

