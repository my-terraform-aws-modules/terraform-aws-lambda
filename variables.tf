variable "region" {
    description = "name of the aws region"
    type = string
    default = "eu-west-1"  
}
variable "create-function" {
    description = "Determines whether resources will be created or not"
    type = bool
    default = true 
}
variable "environment" {
  description = "The environment to deploy to."
  type        = string
  default     = "dev"
  validation {
    condition     = contains(["dev", "prod", "sit", "snd", "uat"], var.environment)
    error_message = "Valid values for var: environment are (dev, prod, sit, snd, uat)."
  }
}
variable "lambda_name" {
    description = "name of the lambda function"
    type = string
    default = "demo-function" 
}
variable "package_filename" {
  description = "The zipped package containing the lambda source code."
  type        = string
  default = "lambda_dynamodb.zip"
}
variable "runtime" {
    description = "Lambda Function runtime"
    type = string
    default = "python3.9"  
}
variable "lambda_handler" {
    description = "give filename & function name which you have mentioned in the file"
    type = string
    default = "lambda_dynamo.lambda_handler"
   
}
variable"create_role"{
    description = "Determines whether role will be created or not"
    type = bool
    default = true
}
variable "lambda_role" {
    description = "Give the name of the lambda role"
    type = string
    default = ""
}
variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}
variable "enable_lambda_trigger" {
    description = "Determines whether lambda trgger will be created or not"
    type = bool
    default = false
  
}
variable "event_source_arn" {
    description = "on which event lambda needs to be trigger"
    type = string
    default = ""
  
}
variable "create-event-invoke" {
    description = "after invoking lambda that need to be sent an event to other resource or not"
    type = bool
    default = false 
}
variable "lambda_arn" {
    description = "the arn of the lambda function"
    type = string
    default = ""
}
variable "lambda_failure_destination_arn" {  
    type = string
    default = ""
}
variable "lambda_success_destination_arn" {  
    type = string
    default = ""
}



  
