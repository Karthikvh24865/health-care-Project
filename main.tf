resource "aws_instance" "Kubernetes-server" {
  ami           = "ami-00bb6a80f01f03502" 
  instance_type = "t3.medium" 
  key_name = "huli"
  vpc_security_group_ids= ["sg-0f9b64f0f5bafa7e0"]
  connection {
    type     = "ssh"
    user     = "ubuntu"
    private_key = file("./huli.pem")
    host     = self.public_ip
  }
 /* provisioner "remote-exec" {
    inline = [ "echo 'wait to start instance' "]
  }
  tags = {
    Name = "Kubernetes-server"
  }
  lifecycle {
    prevent_destroy = true
  }
*/
 // provisioner "local-exec" {
//      command = " echo ${aws_instance.Kubernetes-server.public_ip} > /etc/ansible/hosts "
//  }
// provisioner "local-exec" {
//  command = "echo ${aws_instance.Kubernetes-server.public_ip} | sudo tee /etc/ansible/hosts > /dev/null "
//}
 // provisioner "local-exec" {
  //  command = "echo '${self.public_ip} ansible_ssh_user=ubuntu ansible_ssh_private_key_file=./huli.pem' | sudo tee -a /etc/ansible/hosts > /dev/null"
//  }

 //  provisioner "local-exec" {
 // command = "ansible-playbook /var/lib/jenkins/workspace/HealtcareProject/ansible-playbook.yml "
//  } 
}
