#dynamodb.tf

resource "aws_dynamodb_table" "flask_data" {
  name           = "flask-data"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "id"

  attribute {
    name = "id"
    type = "S"
  }

  tags = {
    Name        = "flask-data"
    Environment = "dev"
  }
}
