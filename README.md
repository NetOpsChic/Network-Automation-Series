# Series 01 - Static Routing on Cisco (Terraform + Ansible + GNS3)

Welcome to the first tutorial in the **Network Automation Series**!  
In this project, we automate a simple Cisco router topology inside **GNS3**, using:

- **Terraform** to deploy the topology
- **Ansible** to configure interface IPs and static routes

The goal is to create a basic 3-router setup where **R1 can ping R3’s loopback** via static routing.

---

## 🔧 What You'll Learn

- How to use **Terraform with GNS3** to deploy Cisco routers and connect them
- How to assign IP addresses and bring interfaces up using **Ansible**
- How to configure **static routes** with Ansible modules
- How to troubleshoot and validate connectivity

---

## 🗂️ Folder Structure
```bash
series-01-static-routing-cisco/
├── terraform/
│   └── main.tf                  
├── ansible/
│   ├── inventory.yml            
│   ├── interfaces.yml          
│   └── static_routes.yml        
└── README.md                    
```
---

## 🧭 Next Up

➡️ [Series 02 - Static Routing on Arista](../series-02-static-routing-arista) *(coming soon)*

---

## 📚 Follow the Blog

Want the full walkthrough with explanations, gotchas, and visuals?

👉 **Follow my blog for the complete tutorial:**  

[Network Automation Series #1: Implementing Basic Static Routing with Terraform & Ansible on a Cisco Router in GNS3](https://medium.com/@netopschic/network-automation-series-1-implementing-basic-static-routing-with-terraform-ansible-on-a-5161a97d73cb)

I cover everything from the why to the how, plus tips on getting around common GNS3 and Ansible issues.

