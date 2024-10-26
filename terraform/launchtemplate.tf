resource "aws_launch_template" "web" {
  name_prefix   = "laravel-web"
  image_id      = "${var.ami_id}"
  instance_type = "${var.ec2_instance_type}"
  key_name = "${var.ssh-keypair-name}"

  iam_instance_profile {
    name = aws_iam_instance_profile.web_profile.name
  }
  metadata_options {
    instance_metadata_tags      = "enabled"
  }

  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_size           = 30
      delete_on_termination = true
      volume_type           = "gp3"
    }
  }
  network_interfaces {
    associate_public_ip_address = true
    delete_on_termination       = true
  }


  vpc_security_group_ids = [aws_security_group.web.id]

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "laravel-web"
    }
  }
}
