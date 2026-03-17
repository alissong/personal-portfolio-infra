resource "aws_instance" "this" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  vpc_security_group_ids = var.security_group_ids
  iam_instance_profile   = var.instance_profile_name
  user_data              = var.user_data
  
  user_data_replace_on_change = true
  associate_public_ip_address = true

  root_block_device {
    volume_size = 10
    volume_type = "gp3"
  }

  tags = {
    Name = "${var.name_prefix}-ec2"
  }
}