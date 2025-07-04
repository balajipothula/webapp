terraform {

backend "s3" {

  region       = "eu-central-1"
  bucket       = "webapp-tf-state-s3-bucket"
  key          = "webapp/tf-state/dev/"

}

//cloud or remote blocks allows to store state remotely in Terraform Cloud.
//cloud block is supported by 1.1.0 or higher versions of Terraform. 
//cloud { }

/*
  backend "remote" {

    hostname = "app.terraform.io"

    # The name of your Terraform Cloud organization.
    organization = "balajipothula"

    # The name of the Terraform Cloud workspace to store Terraform state files in.
    workspaces {
      name   = "webapp"
    }

  }
*/
  required_providers {

    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.55.0"
    }

    github = {
      source  = "integrations/github"
      version = "~> 5.0"
    }

  }

  required_version = ">= 1.0.5"

}
