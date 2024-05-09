FROM docker as docker
FROM bitnami/kubectl:1.27.7 as kubectl
FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive

### Install default packages
RUN apt-get update -y &&\
    apt-get install -y \
    curl \
    git \
    zip \
    yarn \
    npm \
    jq \
    wget \
    apt-transport-https \
    net-tools dnsutils \
    traceroute \
    iputils-tracepath \
    iputils-ping

### Install Helm CLI
COPY ./get_helm.sh .
RUN chmod +x get_helm.sh && bash get_helm.sh

### Install Azure CLI
RUN curl -sL https://aka.ms/InstallAzureCLIDeb | bash \
    && rm -rf /var/lib/apt/lists/*


### Install PowerShell CLI
RUN wget https://github.com/PowerShell/PowerShell/releases/download/v7.3.8/powershell_7.3.8-1.deb_amd64.deb
RUN dpkg -i powershell_7.3.8-1.deb_amd64.deb
RUN apt-get install -f

### Clear cache and change shell ###
RUN apt-get clean && \
    apt-get autoclean && \
    apt-get autoremove -y && \
    rm -rf /var/lib/cache/* && \
    rm -rf /var/lib/log/*

# Can be 'linux-x64', 'linux-arm64', 'linux-arm', 'rhel.6-x64'.
ENV TARGETARCH=linux-x64

WORKDIR /azp

COPY --from=docker/buildx-bin /buildx /usr/libexec/docker/cli-plugins/docker-buildx
COPY --from=kubectl /opt/bitnami/kubectl/bin/kubectl /usr/local/bin/

COPY ./start.sh .
RUN chmod +x start.sh

ENTRYPOINT [ "./start.sh" ]