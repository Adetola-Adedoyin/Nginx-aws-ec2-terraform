terraform {
  backend "s3" {
    bucket         = "sdykbhzdkun"  
    key            = "terraform-state/dev/terraform.tfstate"
    region         = "us-east-1"  
  }
}
