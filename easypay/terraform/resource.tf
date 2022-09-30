provider "aws"{
    region = "us-east-1"
    access_key = var.PATH_PUBLIC_KEY
    secret_key = var.PATH_PRIVATE_KEY
    token      = var.AWS_TOKEN
}

resource "aws_key_pair" "aws_key" {
  key_name   = "aws_key"
  public_key = file(var.PATH_PUBLIC_KEY)
}

resource "aws_security_group" "Kube Sec Group" {

    name = "sg_k8s"
  # Any incoming traffic is allowed
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  # Any outgoing traffic is allowed
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 INSTANCE FOR MASTER
resource "aws_instance" "k8s-master" {
  ami           = var.AMI["ubuntu"]
  instance_type = var.INSTANCE_TYPE
  # Add previously generated public key to VM
  key_name = aws_key_pair.aws_key.key_name
  # Add VM to security group
  vpc_security_group_ids = [aws_security_group.sg_k8s.id]
  tags = {
     Name = "k8s"
     Role = "master"
  }
# Wait for SSH connection to become available, which means VM is up and running
  provisioner "remote-exec" {
    inline = ["echo 'SSH is up!'"]
    connection {
      host        = self.public_ip
      type        = "ssh"
      user        = var.SSH_USER
      private_key = file(var.PATH_TO_PRIVATE_KEY)
    }
  }


}







