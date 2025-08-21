# Demo app flow
![flow](public\workflow.png)

# CI Flow
## 1. create app and push into github

```
https://github.com/Koustav21-dev/demo-app.git
```
## 2. Set up Jenkins 
- Select poll scm with a time of 5 min:
```
H/5 * * * *
```
- Pipeline definition select *__pipeline script from scm__*
![](public/jenkis1.png)
- Go to manage jenkins and under credentials set your nexus credentials
![](/public/jenkins2.png)
- Next under manage jenkins->tools set path to your git.exe
![](/public/jenkins3.png)
## 3. Set up Nexus
- Set up nexus via wsl in your system
```
https://help.sonatype.com/en/install-nexus-repository.html
```
- Note the ip of your wsl vm 
```
ipconfig
```
- create a docker hosted repo in nexus
![](/public/nexus1.png)

- Trigger build to see your image get push into nexus

# CD flow
> Pre-requisites: Minikube installed
## ArgoCD install
- Delete your existing minikube cluster
- Run the command
```
minikube start --insecure-registry "<registry-IP>"
```
- Install argocd
```
kubectl create namespace argocd

kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

```

- Access UI

```
kubectl port-forward svc/argocd-server -n argocd 80xx:x43

```
- Access through local browser

- Login with username: admin and password:
```
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
```

- Set up your nexus secret

```
kubectl create secret docker-registry nexus-reg-cred \
  --docker-server=172.18.X.XX:2000 \
  --docker-username=admin \
  --docker-password=admin12
```

- Write all your K8S manifest as well as argocd manifest

- Run your argocd manifest file 

![](/public/argocd1.png)