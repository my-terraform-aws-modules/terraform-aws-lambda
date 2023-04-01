
/*
data "archive_file" "lambda" {
  type        = "zip"
  source_file = "${path.module}/python/lambda_dynamo/lambda_dynamodb.py"
  output_path = "${path.module}/python/lambda_dynamo/lambda_dynamodb.zip"
}
*/
resource "aws_lambda_function" "test_lambda" {
  count = var.create-function ? 1 : 0
  function_name = "${var.environment}-${var.lambda_name}"
  filename      = var.package_filename #var.package_filename = data.archive_file.lambda.output_path
  role          = var.create_role ? aws_iam_role.lambda.arn : var.lambda_role
  handler       = var.lambda_handler
  source_code_hash = filebase64sha256(var.package_filename)#var.package_filename = data.archive_file.lambda.output_path
  runtime = var.runtime
  tags = var.tags
}

resource "aws_lambda_event_source_mapping" "Example" {
  count = var.enable_lambda_trigger ? 1 : 0
  event_source_arn = var.event_source_arn
  function_name    = var.lambda_arn
}
resource "aws_lambda_function_event_invoke_config" "example" {
  count = var.create-event-invoke ? 1 : 0
  function_name = var.lambda_arn
  destination_config {
    on_failure {
      destination = var.lambda_failure_destination_arn
    }

    on_success {
      destination = var.lambda_success_destination_arn
    }
    }
}

