# remote/s3.tf
resource "aws_s3_bucket" "remote_s3" {
    bucket = "timo-remote-terraform-state-bucket"
    tags = {
      Name = "timo-remote-terraform-state-bucket"
    }
}