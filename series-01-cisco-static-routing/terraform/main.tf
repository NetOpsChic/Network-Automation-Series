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

resource "gns3_project" "project1" {
  name = "cisco-static-routing-lab"
}

data "gns3_template_id" "router_template" {
  name = "c7200"
}

resource "gns3_switch" "switch1" {
  project_id = gns3_project.project1.id
  name       = "Switch1"
  x          = 300
  y          = 300
}

resource "gns3_cloud" "cloud1" {
  project_id = gns3_project.project1.id
  name       = "Cloud1"
  x          = 500
  y          = 100
}

resource "gns3_template" "router1" {
  project_id  = gns3_project.project1.id
  template_id = data.gns3_template_id.router_template.id
  name        = "Router1"
  compute_id  = "local"
  x           = 100
  y           = 100
}

resource "gns3_template" "router2" {
  project_id  = gns3_project.project1.id
  template_id = data.gns3_template_id.router_template.id
  name        = "Router2"
  compute_id  = "local"
  x           = 100
  y           = 300
}

resource "gns3_template" "router3" {
  project_id  = gns3_project.project1.id
  template_id = data.gns3_template_id.router_template.id
  name        = "Router3"
  compute_id  = "local"
  x           = 100
  y           = 500
}

# Router to switch links
resource "gns3_link" "r1_switch" {
  project_id     = gns3_project.project1.id
  node_a_id      = gns3_template.router1.id
  node_a_adapter = 0
  node_a_port    = 0
  node_b_id      = gns3_switch.switch1.id
  node_b_adapter = 0
  node_b_port    = 1
}

resource "gns3_link" "r2_switch" {
  project_id     = gns3_project.project1.id
  node_a_id      = gns3_template.router2.id
  node_a_adapter = 0
  node_a_port    = 0
  node_b_id      = gns3_switch.switch1.id
  node_b_adapter = 0
  node_b_port    = 2
}

resource "gns3_link" "r3_switch" {
  project_id     = gns3_project.project1.id
  node_a_id      = gns3_template.router3.id
  node_a_adapter = 0
  node_a_port    = 0
  node_b_id      = gns3_switch.switch1.id
  node_b_adapter = 0
  node_b_port    = 3
}

# Direct links between routers
resource "gns3_link" "r1_r2" {
  project_id     = gns3_project.project1.id
  node_a_id      = gns3_template.router1.id
  node_a_adapter = 1
  node_a_port    = 0
  node_b_id      = gns3_template.router2.id
  node_b_adapter = 1
  node_b_port    = 0
}

resource "gns3_link" "r2_r3" {
  project_id     = gns3_project.project1.id
  node_a_id      = gns3_template.router2.id
  node_a_adapter = 2
  node_a_port    = 0
  node_b_id      = gns3_template.router3.id
  node_b_adapter = 2
  node_b_port    = 0
}

resource "gns3_link" "switch_cloud" {
  project_id     = gns3_project.project1.id
  node_a_id      = gns3_switch.switch1.id
  node_a_adapter = 0
  node_a_port    = 0
  node_b_id      = gns3_cloud.cloud1.id
  node_b_adapter = 0
  node_b_port    = 2
}

resource "gns3_start_all" "start_nodes" {
  project_id = gns3_project.project1.id

  depends_on = [
    gns3_template.router1,
    gns3_template.router2,
    gns3_template.router3,
    gns3_switch.switch1,
    gns3_cloud.cloud1,
    gns3_link.r1_switch,
    gns3_link.r2_switch,
    gns3_link.r3_switch,
    gns3_link.r1_r2,
    gns3_link.r2_r3,
    gns3_link.switch_cloud,
  ]
}
