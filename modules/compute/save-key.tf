resource "local_file" "private_key" {
  content  = tls_private_key.my_key.private_key_pem
  filename = "${path.module}/my-key.pem"
  file_permission = "0600"
}
