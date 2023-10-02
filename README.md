# README

This README would normally document whatever steps are necessary to get the
application up and running.

## Deployment instructions

* Build the Docker Image:

In the same directory as the Dockerfile, build and push the Docker image using the following command:

docker build -t hello-world-app .

docker tag hello-world-app pujan306/hello-world-app:1.0

docker push pujan306/hello-world-app:1.0

* Change the tag in Helm chart:

helm/hello-world-app/values.yaml

* Deploy into Kubernetes cluster

Run the following commands to deploy the application into Kubernetes cluster:

cd terraform/stage

terraform init

terraform apply

## How would you manage your terraform state file for multiple environments? e.g stage, prod, demo

Managing Terraform state files for multiple environments, such as stage, production, and demo, is a critical aspect of working with Terraform to ensure separation, isolation, and proper versioning.

1. Use Remote State Storage:

Store the Terraform state files remotely rather than locally. Common remote state backends include AWS S3, Azure Blob Storage, Google Cloud Storage, or HashiCorp's Terraform Cloud. I prefer to use AWS S3 for state files, and DynamoDB for locking. Using remote state backends allows you to centralize state management and avoid issues related to state file synchronization.

2. Separate State Files per Environment:

Create separate state files for each environment (e.g., stage, production, demo). This ensures that changes in one environment do not impact the state of another. Organize the state files in a structured manner, such as using directories or naming conventions, to distinguish between environments.
Please look into terraform folder in this repository.

3. Use Workspace or Environment Variables:

Leverage Terraform workspaces or environment-specific environment variables to set configuration values that differ between environments, such as AWS credentials, region, or instance sizes. This allows you to use the same Terraform code across environments while customizing the environment-specific settings.
From my experience, I don't prfer to use this way in the real project, since I need to use difference version of same Terraform module for each environment, and it's not convenient to speicify different version with <workspace> variable.


## How would you approach managing terraform variables and secrets as well?

Managing Terraform variables and secrets is a critical aspect of infrastructure as code (IAC) to ensure both the security and flexibility of deployments.

1. Separate Variables and Secrets:

Differentiate between Terraform variables and secrets. Variables are typically non-sensitive values like instance sizes, counts, and regions. Secrets include sensitive information such as API keys, passwords, and access tokens.

2. Use Terraform Input Variables:

Define non-sensitive variables using Terraform input variables. We can create a variables.tf file to declare and document the variables.

3. Use Environment Variables for Secrets:

For secrets, it's a best practice to use environment variables or a secret management tool rather than hardcoding secrets directly in your Terraform configuration files. We can set environment variables in the shell or use a tool like HashiCorp Vault, AWS Secrets Manager, or Azure Key Vault for secret management. I prefer to use HashCorp Vault or AWS Secrets Manager.

4. Retrieve Secrets Dynamically:

In the Terraform code, we can use data sources or external providers to retrieve secrets from the environment variables or secret management systems. Avoid storing secrets in Terraform configuration files.

Example using AWS Secrets Manager:

data "aws_secretsmanager_secret" "my_secret" {
  name = "my-secret"
}

output "my_secret_value" {
  value = data.aws_secretsmanager_secret.my_secret.secret_string
}