terraform {
  backend "s3" {
    bucket = "masters-state-files"
    region = "us-east-1"
    key = "masters-eac/terraform.tfstate"
    # profile = "saml"
  }
}
