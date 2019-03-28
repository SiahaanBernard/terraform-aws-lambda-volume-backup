module "aws-iam-role_lambda_role" {
  source = "github.com/traveloka/terraform-aws-iam-role.git//modules/lambda?ref=v0.4.3"

  product_domain   = "${var.product_domain}"
  service_name     = "${local.service_name}"
  descriptive_name = "${var.description}"
}

module "aws-resource-naming_lambda" {
  source = "github.com/traveloka/terraform-aws-resource-naming.git?ref=v0.7.1"

  name_prefix   = "${local.service_name}_volume_backup_lambda"
  resource_type = "lambda_function"
}

data "aws_iam_policy_document" "this" {
  statement = {
    sid = "AllowDescribeVolumesAndCreateSnapshot"

    actions = [
      "ec2:CreateSnapshot",
      "ec2:CreateTags",
      "ec2:DescribeInstances",
      "ec2:DescribeSnapshots",
      "ec2:DescribeTags",
      "ec2:DescribeVolumes",
      "ec2:DeleteSnapshot",
    ]

    resources = [
      "*",
    ]
  }

  statement = {
    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    resources = [
      "arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:/aws/lambda/${module.aws-resource-naming_lambda.name}:*",
    ]
  }
}

resource "aws_iam_role_policy" "this" {
  name   = "AllowToCreateSnapshotAndPutLog"
  role   = "${module.aws-iam-role_lambda_role.role_name}"
  policy = "${data.aws_iam_policy_document.this.json}"
}

resource "aws_cloudwatch_log_group" "this" {
  name = "/aws/lambda/${module.aws-resource-naming_lambda.name}"

  tags = {
    Name          = "/aws/lambda/${module.aws-resource-naming_lambda.name}"
    ProductDomain = "${var.product_domain}"
    Service       = "${local.service_name}"
    Environment   = "${var.environment}"
    Description   = "log group for ${module.aws-resource-naming_lambda.name}"
    ManagedBy     = "terraform"
  }
}

resource "aws_lambda_function" "this" {
  filename = "${path.module}/script/main.zip"
  handler  = "main.lambda_handler"

  function_name    = "${module.aws-resource-naming_lambda.name}"
  role             = "${module.aws-iam-role_lambda_role.role_arn}"
  runtime          = "${local.lambda_runtime}"
  memory_size      = "${var.lambda_memory_size}"
  timeout          = "${var.lambda_timeout}"
  source_code_hash = "${base64sha256(file("${path.module}/script/main.zip"))}"

  tags = {
    Name          = "${module.aws-resource-naming_lambda.name}"
    ProductDomain = "${var.product_domain}"
    Service       = "${local.service_name}"
    Environment   = "${var.environment}"
    Description   = "${var.description}"
    ManagedBy     = "terraform"
  }
}
