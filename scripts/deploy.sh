#!/bin/bash

# set exit and logging
set -ex

# check for required tools (AWS CLI and Docker) and exit if not found
command -v aws >/dev/null 2>&1 || {
  echo "Error: AWS CLI not found. Please install it."; exit 1;
}
command -v docker >/dev/null 2>&1 || {
  echo "Error: Docker not found. Please install it."; exit 1;
}

# check that the required env vars have been passed and exit if not
if [ -z "$SOPS_AGE_KEY_FILE" ]; then
  echo "Error: Please set the SOPS_AGE_KEY_FILE environment variable."
  exit 1
fi

if [ -z "$PRIVATE_KEY_PATH" ]; then
  echo "Error: Please set the PRIVATE_KEY_PATH environment variable."
  exit 1
fi

if [ -z "$AWS_ACCESS_KEY_ID" ] || [ -z "$AWS_SECRET_ACCESS_KEY" ]; then
  echo "Error: Please set the AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY."
  exit 1
fi

if [ -z "$GITHUB_TOKEN" ] || [ -z "$GITHUB_USER" ]; then
  echo "Error: Please set both the GITHUB_TOKEN and GITHUB_USER."
  exit 1
fi

# set default variables
IMAGE=${1:-"ghcr.io/marka2g/belly_bot:latest"}
AWS_REGION="eu-west-1"
INSTANCE_TAG_NAME="docker-swarm-manager"
STACK_NAME="belly_bot"

# get EC2 IP address
EC2_MANAGER_IP=$(aws ec2 describe-instances \
    --filters "Name=tag:Name,Values=$INSTANCE_TAG_NAME" \
              "Name=instance-state-name,Values=running" \
    --query "Reservations[0].Instances[0].PublicIpAddress" \
    --region "$AWS_REGION" --output text)

# exit if no running EC2 found
if [ -z "$EC2_MANAGER_IP" ]; then
  echo "Error: No instance found with tag name $INSTANCE_TAG_NAME."
  exit 1
fi

# decrypt secrets and create secret files
./scripts/decrypt.sh

# add private SSH key to ssh-agent
eval "$(ssh-agent -s)"
chmod 600 "$PRIVATE_KEY_PATH"
mkdir -p ~/.ssh/
ssh-add "$PRIVATE_KEY_PATH"

# add EC2 IP to list of known hosts
ssh-keyscan -H "$EC2_MANAGER_IP" >> ~/.ssh/known_hosts

# log in to the GitHub Docker registry
echo "$GITHUB_TOKEN" | docker login ghcr.io \
  -u "$GITHUB_USER" --password-stdin

# deploy the application
DOCKER_HOST="ssh://ec2-user@$EC2_MANAGER_IP" \
WEB_IMAGE="$IMAGE" \
docker stack deploy -c compose.yaml --with-registry-auth "$STACK_NAME"

echo "Deployed Successfully."
