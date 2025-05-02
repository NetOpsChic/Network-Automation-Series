terraform {
  required_providers {
    gns3 = {
      source  = "netopschic/gns3"
      version = "2.5.0"
    }
  }
}

provider "gns3" {
  host = "http://localhost:3080"
}
