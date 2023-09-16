resource "aws_instance" "test-server" {
  ami           = "ami-05552d2dcf89c9b24" 
  instance_type = "t2.micro" 
  key_name = "BabucKeypair"
  vpc_security_group_ids= ["sg-00f7cae4b48423f8c"]
  connection {
    type     = "ssh"
    user     = "ec2-user"
    private_key = file("./BabucKeypair.pem")
    host     = self.public_ip
  }
  provisioner "remote-exec" {
    inline = [ "echo 'wait to start instance' "]
  }
  tags = {
    Name = "test-server"
  }
  provisioner "local-exec" {
        command = " echo ${aws_instance.test-server.public_ip} > inventory "
  }
   provisioner "local-exec" {
  command = "ansible-playbook /var/lib/jenkins/workspace/Banking-Project/my-serverfiles/finance-playbook.yml "
  } 
}
