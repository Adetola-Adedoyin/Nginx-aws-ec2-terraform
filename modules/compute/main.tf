resource "random_id" "sg_suffix" {
  byte_length = 4
}

resource "aws_security_group" "allow_http_ssh" {
  name        = "allow_http_ssh-${random_id.sg_suffix.hex}"  # Unique name
  description = "Allow HTTP and SSH"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_http_ssh"
  }
}


# Ubuntu EC2 Instance with NGINX
resource "aws_instance" "example" {
  ami                         = "ami-04f167a56786e4b09"  #  Ubuntu 22.04 LTS (for us-east-1)
  instance_type               = "t2.micro"
  key_name                    = aws_key_pair.my_key.key_name
  associate_public_ip_address = true
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [aws_security_group.allow_http_ssh.id]

  user_data = <<-EOF
              #!/bin/bash
              set -e  # Exit on error
              apt-get update -y
              apt-get install nginx -y
              systemctl enable nginx
              systemctl start nginx

              cat > /var/www/html/index.html <<EOL
              <!DOCTYPE html>
              <html lang="en">
              <head>
                  <meta charset="UTF-8">
                  <meta name="viewport" content="width=device-width, initial-scale=1.0">
                  <title>Welcome to My Ubuntu Site</title>
                  <style>
                      body {
                          background-color: #0f172a;
                          color: #f8fafc;
                          font-family: Arial, sans-serif;
                          text-align: center;
                          padding-top: 100px;
                      }
                      h1 {
                          font-size: 3em;
                          margin-bottom: 20px;
                      }
                      p {
                          font-size: 1.2em;
                          color: #cbd5e1;
                      }
                  </style>
              </head>
              <body>
                  <h1>🚀 Hello from Terraform + Ubuntu + NGINX!</h1>
                  <p>This static site is running on an Ubuntu EC2 instance provisioned with Terraform.</p>
              </body>
              </html>
              EOL
              EOF

  tags = {
    Name = var.instance_name
  }
}

