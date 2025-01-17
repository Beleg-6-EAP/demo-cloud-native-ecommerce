![Static Badge](https://img.shields.io/badge/GHC-2024-orange)
[![Haskell-CI](https://github.com/Beleg-6-EAP/demo-cloud-native-ecommerce/actions/workflows/haskell-ci.yml/badge.svg)](https://github.com/Beleg-6-EAP/demo-cloud-native-ecommerce/actions/workflows/haskell-ci.yml)

# Cloud-native Architecture E-Commerce Demo

This repository provides a minimal example showcasing the Cloud-native Architecture in an E-Commerce setting.
This setting includes only the payment.

This demo is part of an article on Enterprise Architecture-Patterns.
The article, including the complete explanation of the E-Commerce-Example, can be found [here](https://github.com/Beleg-6-EAP/Belegarbeit).

## Get running on AWS

```bash
# Build binary
bash> stack build --copy-bins

# Create function package
bash> aws cloudformation package \
  --template-file template.yaml \
  --s3-bucket your-existing-bucket > \
  deployment_stack.yaml

# Deploy function
bash> aws cloudformation deploy \
  --stack-name "demo-cloud-native-ecommerce" \
  --region eu-central-1 \
  --capabilities CAPABILITY_IAM \
  --template-file deployment_stack.yaml

# Take it for a spin!
bash> aws lambda invoke \
  --function-name demo-cloud-native-ecommerce \
  --region eu-central-1 \
  --payload '{
    "orderId": "1234-5678-abcd-efgh",
    "userId": "1234-5678-8765-4321",
    "amount": 42.0,
  }' \
  output.txt
```

## Get running locally
```bash
# Build binary
bash> docker pull fpco/stack-build:lts-23.4
bash> stack build --copy-bins

# Run with Docker
bash> echo '{ "accountId": "your_account_id" }' | docker run -i --rm \
    -e DOCKER_LAMBDA_USE_STDIN=1 \
    -v ${PWD}/.stack-work/docker/_home/.local/bin/:/var/task \
    lambci/lambda:provided
```

## Troubleshooting

If there is any trouble or if you have any questions, feel free to open an issue!
