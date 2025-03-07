resource "aws_security_group" "ec2_sg" {

    vpc_id = "${var.VPCID}"
 
    ingress {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        description = "Allow HTTP traffic from CloudFront only"
        cidr_blocks = data.aws_ip_ranges.cloudfront.cidr_blocks
    }
}
 
data "aws_ip_ranges" "cloudfront" {
    
    services = ["CLOUDFRONT"]
    regions  = ["global"]
}
 
resource "aws_security_group" "rds_sg" {

    vpc_id = "${var.VPCID}"
 
    ingress {
        from_port = 5432
        to_port = 5432
        protocol = "tcp"
        description = "Allow PostgreSQL access from EC2"
        security_groups = [aws_security_group.ec2_sg.id]
    }
}