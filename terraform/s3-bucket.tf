resource "aws_s3_bucket" "s3_cloudfront" {

    bucket = "my-frontend-bucket"
}
 
resource "aws_s3_bucket_public_access_block" "s3_public_access_block" {

    bucket = "${aws_s3_bucket.s3_cloudfront.id}"
    block_public_acls   = true
    block_public_policy = true
    restrict_public_buckets = true
    ignore_public_acls      = true
}

data "aws_iam_policy_document" "s3-policy-document" {

    statement {
        actions   = [
            "s3:GetObject",
            "s3:ListBucket"
        ]
        resources = [
            "${aws_s3_bucket.s3_cloudfront.arn}/*",
            "${aws_s3_bucket.s3_cloudfront.arn}"
        ]
        principals {
            type        = "AWS"
            identifiers = ["${aws_cloudfront_origin_access_identity.origin_access_identity.iam_arn}"]
        }
    }
}

resource "aws_s3_bucket_policy" "s3-policy" {

    bucket = "${aws_s3_bucket.s3_cloudfront.id}"
    policy = "${data.aws_iam_policy_document.s3-policy-document.json}"
}

resource "aws_cloudfront_origin_access_identity" "origin_access_identity" {
}
