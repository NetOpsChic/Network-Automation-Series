# Network Automation Series 🚀

This repository contains a hands-on series of labs demonstrating how to automate network device configuration using **Ansible**, **Terraform**, and **GNS3**. Each part focuses on a specific routing protocol or technology and gradually builds toward a fully automated network lab environment.

---

## 📚 Series Structure

### 🔹 Part 1 – Static Routing Automation (Cisco)
- Configure static routes on Cisco routers using **Terraform** + **Ansible**
- Devices: Cisco IOS routers in GNS3

### 🔹 Part 2 – OSPF Routing Protocol (Cisco)
- Automate OSPFv2 configuration using **Ansible `ios_ospfv2` module**
- Interfaces dynamically assigned, networks advertised via automation


### 🔹 [Upcoming] – BGP / EIGRP / ZTP Integration
- Automating more advanced protocols
- Using Zero Touch Provisioning for bootstrapping devices

---

## 📂 Repository Layout

```bash
.
series-XX-XXX-XXXX/
├── terraform/
│   └── main.tf                  
├── ansible/
│   ├── inventory.yml            
│   ├── interfaces.yml          
│   └── XXX.yml        
└── README.md                    
```

## 📚 Follow the Blog

Want the full walkthrough with explanations, gotchas, and visuals?

👉 **Follow my blog for the complete tutorial:**  

[NetOpsChic Medium Blogs](https://medium.com/@netopschic)

I cover everything from the why to the how, plus tips on getting around common GNS3 and Ansible issues.

