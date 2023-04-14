resource "aws_instance" "test-server" {
  ami           = "ami-07d3a50bd29811cd1" 
  instance_type = "t2.micro" 
  key_name = "keypairpem"
  vpc_security_group_ids= ["sg-0ff4024a0cba88baf"]
  connection {
    type     = "ssh"
    user     = "ec2-user"
    private_key = file("./keypairpem.pem")
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
  command = "ansible-playbook /var/lib/jenkins/workspace/Finance_Me_Project/test-server/finance-playbook.yml "
  } 
}
