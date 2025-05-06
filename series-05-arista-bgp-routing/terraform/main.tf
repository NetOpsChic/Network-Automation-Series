# Project definition
resource "gns3_project" "project1" {
  name = "arista-bgp-route"
}

locals {
  arista_template = "arista-eos"
  ztp_template    = "ztp-container"
  compute         = "local"

  routers = {
    arista1 = { x = 100, y = 100 }
    arista2 = { x = 500, y = 100 }
    arista3 = { x = 500, y = 500 }
    arista4 = { x = 100, y = 500 }
  }

  # square topology between routers
  router_links = [
    ["arista1", "arista2"],
    ["arista2", "arista3"],
    ["arista3", "arista4"],
    ["arista4", "arista1"]
  ]
}

# Templates
data "gns3_template_id" "arista" {
  name = local.arista_template
}

data "gns3_template_id" "ztp" {
  name = local.ztp_template
}

# Core switch
resource "gns3_switch" "switch1" {
  project_id = gns3_project.project1.id
  name       = "Switch1"
  x          = 300
  y          = 300
}

# Cloud (for internet)
resource "gns3_cloud" "cloud1" {
  project_id = gns3_project.project1.id
  name       = "Cloud1"
  x          = 600
  y          = 100
}

# ZTP container
resource "gns3_template" "ztp" {
  project_id  = gns3_project.project1.id
  template_id = data.gns3_template_id.ztp.id
  name        = "ZTP"
  compute_id  = local.compute
  x           = 600
  y           = 300
}

# Arista routers
resource "gns3_template" "routers" {
  for_each    = local.routers
  project_id  = gns3_project.project1.id
  template_id = data.gns3_template_id.arista.id
  name        = each.key
  compute_id  = local.compute
  x           = each.value.x
  y           = each.value.y
}

# Inter-router links (uses adapters 1,2,3… on the Arista; port 0)
resource "gns3_link" "router_links" {
  for_each   = { for idx, pair in local.router_links : idx => pair }
  project_id = gns3_project.project1.id

  node_a_id      = gns3_template.routers[each.value[0]].id
  node_a_adapter = each.key + 1   # will use adapter 1,2,3,4 on each Arista
  node_a_port    = 0

  node_b_id      = gns3_template.routers[each.value[1]].id
  node_b_adapter = each.key + 1
  node_b_port    = 0

  depends_on = [gns3_template.routers]
}

resource "gns3_link" "router_switch_links" {
  for_each   = local.routers
  project_id = gns3_project.project1.id

  # Arista side: Management1
  node_a_id      = gns3_template.routers[each.key].id
  node_a_adapter = 0
  node_a_port    = 0

  # Switch side: unique port per router
  node_b_id      = gns3_switch.switch1.id
  node_b_adapter = 0
  node_b_port    = index(keys(local.routers), each.key)

  depends_on = [
    gns3_template.routers,
    gns3_switch.switch1
  ]
}

# Switch → Cloud
resource "gns3_link" "switch_to_cloud" {
  project_id     = gns3_project.project1.id
  node_a_id      = gns3_switch.switch1.id
  node_a_adapter = 0
  node_a_port    = 4
  node_b_id      = gns3_cloud.cloud1.id
  node_b_adapter = 0
  node_b_port    = 2

  depends_on = [
    gns3_switch.switch1,
    gns3_cloud.cloud1
  ]
}

# Switch → ZTP container
resource "gns3_link" "switch_to_ztp" {
  project_id     = gns3_project.project1.id
  node_a_id      = gns3_switch.switch1.id
  node_a_adapter = 0
  node_a_port    = 5
  node_b_id      = gns3_template.ztp.id
  node_b_adapter = 0
  node_b_port    = 0

  depends_on = [
    gns3_switch.switch1,
    gns3_template.ztp
  ]
}

# Start everything
resource "gns3_start_all" "start_nodes" {
  project_id = gns3_project.project1.id

  depends_on = [
    gns3_template.ztp,
    gns3_switch.switch1,
    gns3_cloud.cloud1,
    gns3_template.routers,
    gns3_link.router_links,
    gns3_link.router_switch_links,
    gns3_link.switch_to_cloud,
    gns3_link.switch_to_ztp
  ]
}
