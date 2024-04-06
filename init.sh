#!/bin/bash
# Define the path to the backend file
BACKEND_FILE="backend_configs/azure.tfbackend"
TFVARS_FILE="variables/azure_dev.tfvars"
PLAN_ONLY="false"

# Check if the backend file exists
if [ -f "$BACKEND_FILE" ]; then
    # If the backend file exists, use it for backend configuration
    echo "Backend configuration found. Running 'terraform init' with backend config..."
    terraform init -backend-config="$BACKEND_FILE"
else
    # If the backend file does not exist, run 'terraform init' without backend config
    echo "No backend configuration found. Running 'terraform init' without backend config..."
    terraform init
fi

# Check if the tfvars file exists for plan and apply
if [ -f "$TFVARS_FILE" ]; then
    # If the tfvars file exists, use it for plan and apply
    TFVARS_FILE=$TFVARS_FILE
else
    # If the tfvars file does not exist, use an empty file
    echo "No tfvars file found. Using an empty file..."
    TFVARS_FILE=$TFVARS_FILE
fi

# Validate the Terraform configuration
echo "Running 'terraform validate'..."
terraform validate

# Check if the validation succeeded
if [ $? -eq 0 ]; then
    # If validation succeeded, proceed with plan or apply based on PLAN_ONLY variable
    if [ "$PLAN_ONLY" = true ]; then
        # If PLAN_ONLY is true, run 'terraform plan' with tfvars file
        echo "Running 'terraform plan'..."
        terraform plan -var-file="$TFVARS_FILE"
    else
        # If PLAN_ONLY is not true, run 'terraform apply' with tfvars file
        echo "Running 'terraform apply'..."
        terraform apply -auto-approve -var-file="$TFVARS_FILE"
    fi
else
    # If validation failed, exit with non-zero status code
    echo "Terraform validation failed. Exiting..."
    exit 1
fi

