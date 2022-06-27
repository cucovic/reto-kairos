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
  policy = data.aws_iam_policy_document.permitir_acceso_objetos_s3.json
}

data "aws_iam_policy_document" "permitir_acceso_objetos_s3" {
  statement {
    principal = "*"
    effect = "Allow"

    actions = [
      "s3:GetObject",
      "s3:ListBucket",
    ]

    resources = [
      "arn:aws:s3:::mapfre-gitops-jamapla"
    ]
  }
}