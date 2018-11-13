#!/bin/bash

sudo kubeadm init --config=kubeadm.cfg

sudo cp -f /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

kubectl taint nodes --all node-role.kubernetes.io/master-

echo "-> Applying calico cni..."
kubectl apply -f calico

echo "Done"
