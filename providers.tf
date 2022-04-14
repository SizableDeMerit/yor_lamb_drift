
provider "aws" {
  #profile = var.profile
  region  = "us-east-1"
}
# provider "awxs" {
#   # profile = var.profile
#   # region  = var.region
# }

# provider "aws" {
# 	# checkov:skip=BC_AWS_SECRETS_5: NO HARD CODED SECRETS 
#   alias      = "plain_text_access_keys_provider"
#   region     = "us-west-1"
#   # EXAMPLE FOR NO HARD CODED SECRETS (NOT REAL SECRETS)
#   # access_key = "REMOVED"
#   # secret_key = "REMOVED"
# }

# terraform {
#   backend "s3" {
#     encrypt = true
#   }
# }

# terraform {
#   #required_version = "1.1.2"
#   required_providers {
#     aws = {
#       source  = "hashicorp/awxs"
#       version = "4.8.0"
#     }
#   }
# }

