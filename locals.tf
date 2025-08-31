locals {
  project_name = "tf-techapricate"
  common_tags = {
    Project = local.project_name
    Owner   = "DevOps-Team"
  }
}
