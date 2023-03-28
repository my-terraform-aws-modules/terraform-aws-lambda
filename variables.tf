variable "region" {
    type = string
    default = "eu-west-2"  
}
variable "create-function" {
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
    type = string
    default = "demo-function" 
}
variable "package_filename" {
  description = "The zipped package containing the lambda source code."
  type        = string
}
variable "runtime" {
    type = string
    default = "python3.9"  
}
variable "lambda_handler" {
    description = "give filename & function name which you have mentioned in the file"
    default = "process_sqs.lambda_handler"
   
}
variable"create_role"{
    type = bool
    default = true
}
variable "lambda_role" {
    type = string
    default = ""
}
variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}
variable "create-event-invoke" {
    type = bool
    default = false 
}
variable "lambda_arn" {
    type = string
    default = ""
  
}
variable "sns_arn" {  
    type = string
    default = ""
}
variable "dynamo_id" {
    type = string
    default = ""  
}



  
