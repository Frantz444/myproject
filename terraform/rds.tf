resource "aws_db_instance" "rds" {
    
    identifier = "mydb"
    engine = "${var.RdsEngine}"
    instance_class = "${var.RdsInstanceType}"
    allocated_storage = 20
    db_name = "mydatabase"
    username = "${var.RDSAdminUser}"
    password = "${random_password.pass.result}"
    skip_final_snapshot = true
    publicly_accessible = false
    vpc_security_group_ids = [aws_security_group.rds_sg.id]
}