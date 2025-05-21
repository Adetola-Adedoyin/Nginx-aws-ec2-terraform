terraform {
  backend "s3" {
    bucket         = "sdykbhzdkun"  
    key            = "terraform-state/staging/terraform.tfstate"
    region         = "us-east-2"  
  }
}