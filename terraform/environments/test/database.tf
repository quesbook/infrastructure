# An RDS instance for testing purposes only.
#

# resource "aws_db_instance" "crm_sync_testing" {
#   allocated_storage       = 5
#   engine                  = "postgres"
#   instance_class          = "db.t2.micro"
#   username                = "master"
#   password                = "jd83gkamvn94"
#   vpc_security_group_ids  = ["sg-91eea0e9"]

#   tags {
#     Environment = "${var.environment}"
#   }
# }

# resource "aws_security_group_rule" "all-IN-postgres" {
#   type              = "ingress"
#   from_port         = 0
#   to_port           = 5432
#   protocol          = "tcp"
#   cidr_blocks       = ["0.0.0.0/0"]
#   security_group_id = "sg-91eea0e9"
# }
