terraform {
  required_version = ">= 0.12.29"
}

module "api_gw" {
  source                = "../../module/api-gw"
  lambda_workmotion_arn = module.lambda_workmotion.lambda_workmotion_arn
}

module "lambda_workmotion" {
  source                          = "../../module/lambda"
  workmotion_api_gw_execution_arn = module.api_gw.workmotion_api_gw_execution_arn
}