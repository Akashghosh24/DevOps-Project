Run this command to download agent on linux machine:

wget url
wget https://vstsagentpackage.azureedge.net/agent/3.239.1/vsts-agent-linux-x64-3.239.1.tar.gz

mkdir myagent && cd myagent
tar zxvf vsts-agent-linux-x64-3.239.1.tar.gz

Run: 
./config.sh

# You can configure the agent to run as a system service using the svc.sh script located in the agent directory. 
# Specify the user and use the install command to configure the service.

sudo ./svc.sh install
sudo ./svc.sh start