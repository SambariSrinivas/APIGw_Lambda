resource "aws_iam_role" "lambda_iam" {
  name               = "Lambda_iam_role"
  assume_role_policy = file("${path.module}/lambda-iam-role.json")
}

resource "aws_iam_policy" "lambda-iam-cloudwatch-policy" {
  name        = "lambda-iam-cloudwatch-policy"
  description = "policy for cloudwatch"
  policy      = file("${path.module}/lambda-iam-cloudwatch-policy.json")
}

resource "aws_iam_policy" "lambda-iam-lambda-policy" {
  name        = "lambda-iam-lambda-policy"
  description = "policy for lambda"
  policy      = file("${path.module}/lambda-iam-lambda-policy.json")
}

resource "aws_iam_role_policy_attachment" "lambda-iam-cloudwatch-policy-attach" {
  role       = aws_iam_role.lambda_iam.name
  policy_arn = aws_iam_policy.lambda-iam-cloudwatch-policy.arn
}

resource "aws_iam_role_policy_attachment" "lambda-iam-lambda-policy-attach" {
  role       = aws_iam_role.lambda_iam.name
  policy_arn = aws_iam_policy.lambda-iam-lambda-policy.arn
}