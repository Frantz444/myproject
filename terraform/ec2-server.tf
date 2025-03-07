resource "aws_instance" "server" {
  
	count = "${var.InstanceCount}"
	ami = "${var.Ami_id}"
	instance_type = "${var.EC2_instance_type}"
  	security_groups = [aws_security_group.ec2_sg.id]

}