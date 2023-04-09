terraform {
  cloud {
    organization = "AWS_Training"

    workspaces {
      name = "Production"
      prefix = "prod-"
    }

    workspaces {
      name = "Develop"
      prefix = "dev-"
    }

    workspaces {
      name = "Stage"
      prefix = "stage-"
    }
  }
}
