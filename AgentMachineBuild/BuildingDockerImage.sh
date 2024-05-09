# This is an instruction document to build docker image and push it to Azure Container Repository.
# This Docker Image will be acting as an agent machine which will have all the necessary tools installed- Docker, Helm, Kubectl etc.

# Pre-Requisite:
# 1. Linux Machine to build the docker image, also make sure docker is installed and running on it.
# 2. ACR is available with a regitry name.
# 3. Make sure the three files to build the image are available - Dockerfile, get_helm.sh, start.sh
# 4. Make sure AZ CLI installed. 

# Name of ACR is the app name itself
# Name of our Repositry name is dockeragent

#Variables- Replace accordingly. Initialize it on the linux CLI by running the below variable commands.

Subscription="z10-ps-dev"
ACR="containerakash"
Repository="dockeragent"
Tag="agent-v02-ubuntu-20.04"


#Login to Azure
az login 


#Set Subscription context to where to ACR container is
az account set --subscription $Subscription

# Login to ACR  
# az acr login -n <ACR Name"
az acr login -n $ACR

#Clone the Git Repo to get the Dockerfile,get_helm.sh , start.sh locally.
git clone https://github.com/Akashghosh24/DevOps-Project.git

# Make sure you are in the directory where the three files are Dockerfile, get_helm.sh, start.sh to build docker image.
cd /DevOps-Project
cd /AgentMachineBuild

# After Successful build the image will be automatically pushed to ACR. 
# Please Note: - The image build process is a time taking process so it will easily take 10-15 minutes to build the image and push it to ACR 

# Building docker Image and Pushing to ACR
# az acr build -t dockeragent:agent-v01-ubuntu-20.04 -r containerakash -f ./Dockerfile . 
az acr build -t $Repository:$Tag -r $ACR -f ./Dockerfile .



# Testing the Validity :This is Optional. Pulling the Docker Image and running on any machine tot test if it is working fine
#docker pull dockeragent:agent-v01-ubuntu-20.04 -r containerakash 
docker pull $ACR.azurecr.io/$Repository:$Tag

