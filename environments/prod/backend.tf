terraform {
  backend "s3" {
    bucket         = "sdykbhzdkun"  
    key            = "terraform-state/prod/terraform.tfstate"
    region         = "us-east-2"  
  }
}