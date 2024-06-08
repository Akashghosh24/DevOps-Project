#User_Data

# This will Install Major Utility Plugins to run on Linux Base Machine.
# 1. Az CLI 
# 2. Docker
# 3. Kubectl 
# 4. Helm
# 5. Node JS for Npm 
# 6. Docker Compose is separately needed other than Docker.




#!/bin/bash

#First Install AZ CLI
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
sudo apt-get update
sudo apt-get install apt-transport-https ca-certificates curl gnupg lsb-release
sudo mkdir -p /etc/apt/keyrings
curl -sLS https://packages.microsoft.com/keys/microsoft.asc |
  sudo gpg --dearmor -o /etc/apt/keyrings/microsoft.gpg
sudo chmod go+r /etc/apt/keyrings/microsoft.gpg
AZ_DIST=$(lsb_release -cs)
echo "Types: deb
URIs: https://packages.microsoft.com/repos/azure-cli/
Suites: ${AZ_DIST}
Components: main
Architectures: $(dpkg --print-architecture)
Signed-by: /etc/apt/keyrings/microsoft.gpg" | sudo tee /etc/apt/sources.list.d/azure-cli.sources
sudo apt-get update
sudo apt-get install azure-cli




#Install Docker
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y




#Install Kubectl
sudo snap install kubectl --classic

#Install Helm
sudo snap install helm --classic

#Manual Installation of NodeJS and NPM
#Install NVM to install latest version of NodeJS and NPM both
# installs nvm (Node Version Manager)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
#Open a new terminal 
# download and install Node.js
nvm install 22
# verifies the right Node.js version is in the environment
node -v # should print `v22.2.0`
# verifies the right NPM version is in the environment
npm -v # should print `10.7.0`


#Install Docker Compose 2.3.3
mkdir -p ~/.docker/cli-plugins/
curl -SL https://github.com/docker/compose/releases/download/v2.3.3/docker-compose-linux-x86_64 -o ~/.docker/cli-plugins/docker-compose
# Next, set the correct permissions so that the docker compose command is executable
chmod +x ~/.docker/cli-plugins/docker-compose
# To verify that the installation was successful, you can run:
docker compose version

