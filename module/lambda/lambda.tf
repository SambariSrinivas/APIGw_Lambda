# Archive a python file.
data "archive_file" "source" {
  type        = "zip"
  source_dir  = "${path.module}/src"
  output_path = "${path.module}/archive/lambda.zip"
}

# create and deploy lambda
resource "aws_lambda_function" "lambda_workmotion" {
  filename         = data.archive_file.source.output_path
  function_name    = "Lambda_Workmotion"
  role             = aws_iam_role.lambda_iam.arn
  handler          = "lambda.lambda_handler"
  source_code_hash = filebase64sha256(data.archive_file.source.output_path)
  runtime          = "python3.8"
  environment {
    variables = {
      env = "dev"
    }
  }
}

# permit Api-Gw for lambda
resource "aws_lambda_permission" "lambda_permission" {
  statement_id  = "AllowAPIGatewayWorkMotion"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.lambda_workmotion.arn
  principal     = "apigateway.amazonaws.com"
  # The /*/*/* part allows invocation from any stage, method and resource path
  # within API Gateway REST API.
  source_arn    = "${var.workmotion_api_gw_execution_arn}/*/*/*"
}