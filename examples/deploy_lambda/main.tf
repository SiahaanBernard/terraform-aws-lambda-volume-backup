module "aws-ebs-automatic-backup" {
  source         = "../../"
  product_domain = "tsi"
  environment    = "staging"
}
