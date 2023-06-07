terraform {
  backend "s3" {
    bucket = "terraform-project-serag"
    key    = "terraform.tfstate"
    region = "us-east-1"
  }
}
