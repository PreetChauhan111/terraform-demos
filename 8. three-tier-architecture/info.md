# Project Title

Design and Implementation of a Secure Multi-VPC Architecture Using VPC Peering on AWS

# Project Overview

This project demonstrates the design and implementation of a secure, scalable, and highly isolated cloud network architecture on AWS using VPC Peering. The architecture separates application components across multiple VPCs to improve security, fault isolation, and traffic control, while still enabling private communication between services.

The setup includes:

  A frontend and backend application tier deployed in a public subnet

  A database tier (Amazon RDS) hosted in a private subnet of a separate VPC

  VPC Peering Connection to enable private, low-latency communication between application and database layers

  Strict route tables, network ACLs, and security groups to enforce least-privilege networking

# Flow

1. User → Application

  User accesses the frontend EC2 instance via the Internet Gateway.

2. Frontend → Backend

  Internal communication occurs within the same public subnet.

3. Backend → Database

  Backend EC2 sends traffic to the RDS instance using private IPs.
  Route tables forward traffic through the VPC Peering Connection.

4. Database Response

  RDS responds back through the peering connection to the backend instance.