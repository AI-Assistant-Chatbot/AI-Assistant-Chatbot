#!/bin/bash

# Amazon Bedrock Knowledge Base Slack Bot - Terraform Deployment Script

set -e

echo "🚀 Amazon Bedrock Knowledge Base Slack Bot - Terraform Deployment"
echo "=================================================================="

# Check if terraform.tfvars exists
if [ ! -f "terraform.tfvars" ]; then
    echo "❌ Error: terraform.tfvars file not found!"
    echo "Please copy terraform.tfvars.example to terraform.tfvars and configure your variables."
    exit 1
fi

# Check if required variables are set
if ! grep -q "slack_bot_token.*=" terraform.tfvars || ! grep -q "slack_signing_secret.*=" terraform.tfvars; then
    echo "❌ Error: Missing required Slack configuration in terraform.tfvars"
    echo "Please ensure slack_bot_token and slack_signing_secret are configured."
    exit 1
fi

echo "✅ Configuration file found"

# Initialize Terraform
echo "🔧 Initializing Terraform..."
terraform init

# Validate configuration
echo "🔍 Validating Terraform configuration..."
terraform validate

# Plan deployment
echo "📋 Creating deployment plan..."
terraform plan -out=tfplan

# Ask for confirmation
echo ""
read -p "Do you want to proceed with the deployment? (y/N): " -n 1 -r
echo ""

if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo "🚀 Deploying infrastructure..."
    terraform apply tfplan
    
    echo ""
    echo "✅ Deployment completed successfully!"
    echo ""
    echo "📋 Important outputs:"
    echo "===================="
    terraform output
    
    echo ""
    echo "🔗 Next steps:"
    echo "1. Configure your Slack App with the API Gateway URL above"
    echo "2. Upload documents to the S3 bucket"
    echo "3. Sync the Knowledge Base data source in AWS Console"
    echo "4. Test your Slack bot with: /xhaly <your question>"
    
else
    echo "❌ Deployment cancelled"
    rm -f tfplan
    exit 1
fi

# Clean up plan file
rm -f tfplan

echo ""
echo "🎉 Setup complete! Your Slack bot is ready to use."