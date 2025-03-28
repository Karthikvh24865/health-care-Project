resource "aws_instance" "test-server" {
  ami           = "ami-00bb6a80f01f03502" 
  instance_type = "t3.medium" 
  key_name = "Prabhu"
  vpc_security_group_ids= ["sg-0ce7a707b375e270d"]
  connection {
    type     = "ssh"
    user     = "ubuntu"
    private_key = file("./Prabhu.pem")
    host     = self.public_ip
  }
  provisioner "remote-exec" {
    inline = [ "echo 'wait to start instance' "]
  }
  tags = {
    Name = "Kubernetes-server"
  }
 // provisioner "local-exec" {
//      command = " echo ${aws_instance.test-server.public_ip} > /etc/ansible/hosts "
//  }
// provisioner "local-exec" {
//  command = "echo ${aws_instance.test-server.public_ip} | sudo tee /etc/ansible/hosts > /dev/null "
//}
  provisioner "local-exec" {
    command = "echo '${self.public_ip} ansible_ssh_user=ubuntu ansible_ssh_private_key_file=./Prabhu.pem' | sudo tee -a /etc/ansible/hosts > /dev/null"
  }

   provisioner "local-exec" {
  command = "ansible-playbook /var/lib/jenkins/workspace/health-care-project/ansible-playbook.yml "
  } 
}
