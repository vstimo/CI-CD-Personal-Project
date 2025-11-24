# remote/dynamo.tf
resource "aws_dynamodb_table" "dynamodb-state-table" {
  name           = "timo-remote-terraform-state-table"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name = "timo-remote-terraform-state-table"
  }
}