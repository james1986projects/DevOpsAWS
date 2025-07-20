#dynamodb.tf

resource "aws_dynamodb_table" "flask_data" {
  name           = "${var.environment}-${var.dynamodb_table_name}"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "id"

  attribute {
    name = "id"
    type = "S"
  }

  tags = {
    Name         = "${var.environment}-${var.dynamodb_table_name}"
    Environment  = var.environment
  }
}
