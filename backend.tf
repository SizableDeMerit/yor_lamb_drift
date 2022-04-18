terraform {
  backend "s3" {
    bucket = "terraform-testing-backend-chuck-norris"
    key    = "chuck-norris"
    region = "us-east-1"
  }
}
