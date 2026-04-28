# Infrastructure as Code - Week 6

This folder contains the Terraform configuration for managing AWS infrastructure as code.

## Tool

Terraform was selected as the Infrastructure as Code tool.

## Defined resources

- AWS provider configuration
- EC2 instance
- Security group for HTTP and Flask application traffic
- Terraform outputs for created resource IDs

## Files

- `provider.tf` - AWS provider and region configuration
- `main.tf` - EC2 instance definition
- `security_group.tf` - Security group rules
- `variables.tf` - reusable variables
- `outputs.tf` - Terraform outputs

## Notes

This setup is prepared as a Week 6 IaC exercise.  
The Terraform configuration is intended to demonstrate how AWS resources can be defined as code.

To avoid unnecessary AWS costs, resources should only be deployed after checking the plan carefully.