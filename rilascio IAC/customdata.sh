#!/bin/bash
# Install docker in centos

# Remove any old versions
sudo yum remove docker docker-common docker-selinux docker-engine

# Install required packages
sudo yum install -y yum-utils device-mapper-persistent-data lvm2

# Configure docker repository
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

# Install Docker-ce
sudo yum install docker-ce -y

# Start Docker
sudo systemctl start docker
sudo systemctl enable docker

# Post Installation Steps
# Create Docker group
sudo groupadd docker

# Add user to the docker group
sudo usermod -aG docker $USER

# Install docker-compose
curl -L "https://github.com/docker/compose/releases/download/1.25.3/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

# Permssion +x execute binary
chmod +x /usr/local/bin/docker-compose

# Create link symbolic 
ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

# Check Version docer-compose

docker-compose --version

installdependencies()

{

yum install -y epel-release

firewall-cmd — add-port=8080/tcp — permanent — zone=public

firewall-cmd — reload

setenforce 0

sed -i 's/SELINUX=enforcing/SELINUX-disabled/g' /etc/selinux/config

sudo yum upgrade -y 

sudo yum install java-11-openjdk -y

}

installJenkins()

{

# Install Jenkins

sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo

sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key

sudo yum install jenkins -y

sudo systemctl enable jenkins

sudo firewall-cmd --permanent --zone=public --add-port=8080/tcp
sudo firewall-cmd --reload

sudo cat /var/lib/jenkins/secrets/initialAdminPassword


}

installAzCLI()

{
    sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc

    sudo sh -c 'echo -e "[azure-cli]

name=Azure CLI

baseurl=https://packages.microsoft.com/yumrepos/azure-cli

enabled=1

gpgcheck=1

gpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/azure-cli.repo'

sudo yum install azure-cli -y
}

installKube()

{

sudo su 

cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF

sudo yum install -y kubelet kubeadm kubectl

sudo systemctl enable kubelet

sudo systemctl start kubelet

sudo firewall-cmd --permanent --add-port=6443/tcp

sudo firewall-cmd --permanent --add-port=2379-2380/tcp

sudo firewall-cmd --permanent --add-port=10250/tcp

sudo firewall-cmd --permanent --add-port=10251/tcp

sudo firewall-cmd --permanent --add-port=10252/tcp

sudo firewall-cmd --permanent --add-port=10255/tcp

sudo firewall-cmd --reload

cat <<EOF > /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF

sysctl --system

sudo setenforce 0

sudo sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config

sudo sed -i '/swap/d' /etc/fstab

sudo swapoff -a
}

installGit()
{
    sudo yum install -y git*

    sudo su

    systemctl restart jenkins.service
}

installTrivy()
{
sudo su

cat <<EOF > /etc/yum.repos.d/trivy.repo
[trivy]
name=Trivy repository
baseurl=https://aquasecurity.github.io/trivy-repo/rpm/releases/$releasever/$basearch/
gpgcheck=0
enabled=1
EOF

sudo yum -y install trivy

}

installdependencies

installJenkins

#Install Azure CLI
installAzCLI

installKube

installGit

installTrivy
