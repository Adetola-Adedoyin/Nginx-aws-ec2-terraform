terraform {
  backend "s3" {
    bucket         = "terraform-claswork-xyst"  
    key            = "terraform-state/prod/terraform.tfstate"
    region         = "us-east-2"  
  }
}