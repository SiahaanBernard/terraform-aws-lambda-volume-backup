output "lambda_arn" {
  description = "lambda arn for volume backup "
  value       = "${module.aws-ebs-automatic-backup.lambda_arn}"
}

output "lambda_name" {
  description = "lambda name for volume backup"
  value       = "${module.aws-ebs-automatic-backup.lambda_name}"
}
