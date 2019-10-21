terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    organization = "arunorg"

    workspaces {
      name = "awsapp"
    }
  }
}