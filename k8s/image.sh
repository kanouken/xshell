#!/bin/bash
# 国内镜像节点替换
images=(kube-apiserver:v1.13.3 kube-controller-manager:v1.13.3 kube-scheduler:v1.13.3 kube-proxy:v1.13.3 etcd:3.2.24 pause:3.1 )
for imageName in ${images[@]} ; do
docker pull mirrorgooglecontainers/$imageName
docker tag docker.io/mirrorgooglecontainers/$imageName k8s.gcr.io/$imageName
docker rmi docker.io/mirrorgooglecontainers/$imageName
done


#core dns
docker pull coredns/coredns:1.2.6
docker tag docker.io/coredns/coredns:1.2.6  k8s.gcr.io/coredns:1.2.6
docker rmi docker.io/coredns/coredns:1.2.6


#flannel
docker pull jmgao1983/flannel:v0.10.0-amd64
docker tag jmgao1983/flannel:v0.10.0-amd64 quay.io/coreos/flannel:v0.10.0-amd64
docker rmi jmgao1983/flannel:v0.10.0-amd64
