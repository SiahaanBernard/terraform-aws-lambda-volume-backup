# terraform-aws-volume-backup
Terraform module to create AWS Lambda function to backup ebs volume. However primary usage of this lambda function is to backup mongodb database, this lambda will create snapshot of mongodb EBS Volume and retain the snapshot based on the defined retention policy. 
We used CloudWatch Event Rule to trigger the lambda function, and pass some information or payload regarding database, and the retention policy to the lambda function.

## Resource Created by this Module
- [aws_iam_role](https://www.terraform.io/docs/providers/aws/d/iam_role.html)
- [aws_cloudwatch_log_group](https://www.terraform.io/docs/providers/aws/r/cloudwatch_log_group.html)
- [aws_lambda_function](https://www.terraform.io/docs/providers/aws/r/lambda_function.html)


## Usage
See [Example deploy lambda function](examples/deploy_lambda/main.tf) to know how to deploy this module.

## Authors
- [Bernard Siahaan](https://github.com/siahaanbernard/)
- [Rafi Kurni Putra](https://github.com/rafikurnia)

## License
Apache 2 Licensed. See [LICENSE](LICENSE) for full details.