resource "aws_cloudfront_distribution" "s3_distribution" {

    origin {
        domain_name = "${aws_s3_bucket.s3_cloudfront.bucket_regional_domain_name}"
        origin_id   = "S3-frontend"

        s3_origin_config {
            origin_access_identity = "${aws_cloudfront_origin_access_identity.origin_access_identity.cloudfront_access_identity_path}"
        }
    }
    
    enabled             = true
    is_ipv6_enabled     = true
    default_root_object = "index.html"
    price_class         = "PriceClass_All"

    restrictions {
        geo_restriction {
            restriction_type = "none"
        }
    }

    viewer_certificate {
        cloudfront_default_certificate = true
    }

    default_cache_behavior {
        viewer_protocol_policy = "redirect-to-https"
        allowed_methods  = ["GET", "HEAD"]
        cached_methods   = ["GET", "HEAD"]
        target_origin_id = "S3-frontend"
        compress = true
    }

    custom_error_response {
        error_caching_min_ttl = 10
        error_code = 404
        response_code = 200
        response_page_path = "/index.html"
    }
}