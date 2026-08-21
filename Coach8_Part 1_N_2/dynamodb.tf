module "dynamodb_table" {
  source  = "terraform-aws-modules/dynamodb-table/aws"
  version = "~> 4.0"

  name      = "${local.name_prefix}-bookinventory"
  hash_key  = "ISBN"
  range_key = "Genre"

  attributes = [
    {
      name = "ISBN"
      type = "S"
    },

    {
      name = "Genre"
      type = "S"
    }
  ]

  tags = {
    Name        = "${local.name_prefix}-table"
    Environment = local.environment
  }
}