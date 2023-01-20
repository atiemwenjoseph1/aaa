###### Computing ######

# resource "aws_instance" "enoch_intance" {
#   ami                 = "ami-0d09654d0a20d3ae2"
#   instance_type       = "t2.micro"
#   vpc_securtity_group = aws_security_group.esecurity.id
#   subnet              = aws_subnet.epublic.id
#   count               = 1
#   tags = {
#     Name = "Enoch EC2 Instance"
#   }
#   # iam = 
#   # user_data =
#   # provisioner =
# }