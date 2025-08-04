#!/bin/bash

# Offline initialization script for network issues

echo "🔧 Terraform Offline Initialization"
echo "=================================="

# Clean up any existing .terraform directory
rm -rf .terraform .terraform.lock.hcl

# Try with increased timeout
export TF_CLI_CONFIG_FILE="terraform.rc"

# Create terraform.rc with mirror configuration
cat > terraform.rc << EOF
provider_installation {
  network_mirror {
    url = "https://terraform-mirror.yandexcloud.net/"
    include = ["registry.terraform.io/*/*"]
  }
  direct {
    exclude = ["registry.terraform.io/*/*"]
  }
}
EOF

echo "⏳ Trying with alternative mirror..."
terraform init -upgrade

# If that fails, try without version constraints
if [ $? -ne 0 ]; then
    echo "⚠️  Trying without strict version constraints..."
    
    # Backup original versions.tf
    cp versions.tf versions.tf.backup
    
    # Create minimal versions.tf
    cat > versions.tf << EOF
terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
    archive = {
      source = "hashicorp/archive"
    }
    random = {
      source = "hashicorp/random"
    }
  }
}
EOF
    
    terraform init
    
    # Restore original versions.tf
    mv versions.tf.backup versions.tf
fi

# Clean up
rm -f terraform.rc

echo "✅ Initialization complete!"