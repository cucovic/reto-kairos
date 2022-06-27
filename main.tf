provider "aws" {
  region  = "eu-west-1"
}
resource "aws_s3_bucket" "mapfre-gitops-jamapla" {
  bucket = "mapfre-gitops-jamapla"

  tags = {
    Name        = "mapfre-gitops-jamapla"
    Environment = "Reto-Kairos"
  }
}

resource "aws_s3_bucket_acl" "mapfre-gitops-jamapla" {
  bucket = aws_s3_bucket.mapfre-gitops-jamapla.id
  acl    = "public-read"
}