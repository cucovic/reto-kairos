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

resource "aws_s3_object" "object" {
  bucket = aws_s3_bucket.mapfre-gitops-jamapla.id
  key    = "index.html"
  source = "./index.html"
  etag = filemd5("./index.html")
}

resource "aws_s3_bucket_policy" "allow_access_from_another_account" {
  bucket = aws_s3_bucket.mapfre-gitops-jamapla.id
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": [
                "s3:GetObject"
            ],
            "Resource": [
                "arn:aws:s3:::mapfre-gitops-jamapla/*"
            ]
        }
    ]
}
EOF
}