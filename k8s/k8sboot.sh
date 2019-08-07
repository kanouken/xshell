#!/bin/bash
#kubeadm 创建集群的准备脚本
setenforce 0
sed -i "s/^SELINUX=enforcing/SELINUX=disabled/g" /etc/sysconfig/selinux

cat <<EOF >  /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF

systemctl stop firewalld
systemctl disable firewalld

yum install -y epel-release

yum install -y net-tools wget vim  ntpdate

ntpdate ntp1.aliyun.com


yum install -y yum-utils device-mapper-persistent-data lvm2

sudo yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo

yum install -y --setopt=obsoletes=0 \    docker-ce-17.03.2.ce-1.el7.centos.x86_64 \    docker-ce-selinux-17.03.2.ce-1.el7.centos.noarch

# Start docker service
systemctl enable docker
systemctl start docker
#检查docker是否成功启动
docker version

#aliyun docker mirror

mkdir -p /etc/docker

tee /etc/docker/daemon.json <<-'EOF'
{ "registry-mirrors": ["https://rflxlgcf.mirror.aliyuncs.com"] ,   "insecure-registries":["192.168.0.5:6000"] }
EOF

systemctl daemon-reload
systemctl restart docker


#install kubeadm kubelet kubectl

cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://mirrors.aliyun.com/kubernetes/yum/repos/kubernetes-el7-x86_64/
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://mirrors.aliyun.com/kubernetes/yum/doc/yum-key.gpg
https://mirrors.aliyun.com/kubernetes/yum/doc/rpm-package-key.gpg
EOF

setenforce 0

yum install -y kubelet kubeadm kubectl --nogpgcheck

systemctl enable kubelet
systemctl start kubelet

echo "all done"
