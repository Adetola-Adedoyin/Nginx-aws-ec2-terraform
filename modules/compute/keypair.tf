# Generate a random suffix
resource "random_id" "suffix" {
  byte_length = 4
}

# Create private key
resource "tls_private_key" "my_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Create AWS Key Pair with a unique name
resource "aws_key_pair" "my_key" {
  key_name   = "my-key-${random_id.suffix.hex}"
  public_key = tls_private_key.my_key.public_key_openssh
}

# Output the private key securely
output "private_key_pem" {
  value     = tls_private_key.my_key.private_key_pem
  sensitive = true
}
