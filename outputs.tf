output "lambda_arn" {
  description = "lambda arn for volume backup "
  value       = "${aws_lambda_function.this.arn}"
}

output "lambda_name" {
  description = "lambda name for volume backup"
  value       = "${module.aws-resource-naming_lambda.name}"
}
