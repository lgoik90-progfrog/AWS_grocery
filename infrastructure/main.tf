resource "aws_instance" "example" {
  ami                    = "ami-0c55b159cbfafe1f0"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.grocerymate_web_sg.id]

  tags = {
    Name = "grocerymate-ec2"
  }
}