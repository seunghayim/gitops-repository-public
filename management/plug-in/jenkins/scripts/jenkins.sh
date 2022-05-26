#!usr/bin/env sh

# Create namespace
kubectl create namespace jenkins
kubectl get ns

# Configure Helm
helm repo add jenkinsci https://charts.jenkins.io
helm repo update
helm search repo jenkinsci

# Create SA / SC / PVC
kubectl kustomize ../ | kubectl apply -f -

# Install jenkins
chart=jenkinsci/jenkins
helm install jenkins -n jenkins -f jenkins-values.yaml $chart

# Get your 'admin' user password
jsonpath="{.data.jenkins-admin-password}"
secret=$(kubectl get secret -n jenkins jenkins -o jsonpath=$jsonpath)
echo $(echo $secret | base64 --decode)

# Get the Jenkins URL to visit
jsonpath="{.spec.ports[0].nodePort}"
NODE_PORT=$(kubectl get -n jenkins -o jsonpath=$jsonpath services jenkins)
jsonpath="{.items[0].status.addresses[0].address}"
NODE_IP=$(kubectl get nodes -n jenkins -o jsonpath=$jsonpath)
echo http://$NODE_IP:$NODE_PORT/login

# Running
kubectl get pods -n jenkins