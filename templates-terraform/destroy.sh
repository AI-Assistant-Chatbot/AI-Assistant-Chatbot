#!/bin/bash

# Amazon Bedrock Knowledge Base Slack Bot - Terraform Destroy Script

set -e

echo "🗑️  Amazon Bedrock Knowledge Base Slack Bot - Terraform Destroy"
echo "==============================================================="

# Check if terraform state exists
if [ ! -f "terraform.tfstate" ] && [ ! -f ".terraform/terraform.tfstate" ]; then
    echo "❌ No Terraform state found. Nothing to destroy."
    exit 1
fi

echo "⚠️  WARNING: This will destroy ALL resources created by this Terraform configuration!"
echo "This includes:"
echo "- S3 bucket and all its contents"
echo "- Bedrock Knowledge Base"
echo "- OpenSearch Serverless collection"
echo "- Lambda functions"
echo "- API Gateway"
echo "- Secrets Manager secrets"
echo "- All associated IAM roles and policies"

echo ""
read -p "Are you sure you want to destroy all resources? Type 'yes' to confirm: " -r

if [[ $REPLY == "yes" ]]; then
    echo "🔍 Planning destruction..."
    terraform plan -destroy -out=destroy-plan
    
    echo ""
    read -p "Proceed with destruction? (y/N): " -n 1 -r
    echo ""
    
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo "🗑️  Destroying infrastructure..."
        terraform apply destroy-plan
        
        echo ""
        echo "✅ All resources have been destroyed successfully!"
        echo "💡 Don't forget to:"
        echo "   - Remove the Slack App configuration"
        echo "   - Clean up any local files if needed"
        
    else
        echo "❌ Destruction cancelled"
        rm -f destroy-plan
        exit 1
    fi
    
    # Clean up plan file
    rm -f destroy-plan
    
else
    echo "❌ Destruction cancelled. Resources remain intact."
    exit 1
fi

echo ""
echo "🎯 Cleanup complete!"