### informações de rascunho
ansible --user=root -m hostname -a "name=kube01" kube01
ansible --user=root -m hostname -a "name=kube02" kube02
ansible --user=root -m hostname -a "name=kube03" kube03


# COPIAR ARQUIVOS
rsync --delete -avzh -e "ssh -q -p2222 -i /home/lpgomes/Dropbox/TRF5/Chaves/Private-semsenha.openssh" /home/lpgomes/Dropbox/zabbix/zabbix-kubernetes-trf5 root@kube01h:/root/
rsync --delete -avzh -e "ssh -q -p2222 -i /home/lpgomes/Dropbox/TRF5/Chaves/Private-semsenha.openssh" /home/lpgomes/Dropbox/kubernetes root@kube01h:/root/

# DICA
source <(kubectl completion bash)

# HOSTS
10.1.13.101	kube01h
10.1.13.104	kube02h
10.1.13.128	kube03h
10.1.13.149	kube04h
10.1.13.120 kube05h
10.1.13.186 kube06h
10.1.14.24 kube07h
10.1.13.107 kube08h


set address kube01h.trf5.gov.br ip-netmask 10.1.13.101
set address kube02h.trf5.gov.br ip-netmask 10.1.13.104
set address kube03h.trf5.gov.br ip-netmask 10.1.13.128
set address kube04h.trf5.gov.br ip-netmask 10.1.13.149
set address kube05h.trf5.gov.br ip-netmask 10.1.13.120
set address kube07h.trf5.gov.br ip-netmask 10.1.13.186
set address kube06h.trf5.gov.br ip-netmask 10.1.14.24 
set address kube08h.trf5.gov.br ip-netmask 10.1.13.107


# ANSIBLE
[kubeh]
kube01h
kube02h
kube03h
kube04h
kube05h
kube06h
kube07h
kube08h

# LINKS UTEIS
https://stackoverflow.com/questions/54341432/deploy-war-in-tomcat-on-kubernetes
https://github.com/kubernetes/kubernetes/issues/67702
https://trello.com/atomicopenshift
https://trello.com/c/DhMVLQHA/381-1-enable-cpu-and-memory-accounting-when-packaging-kubernetes
https://github.com/arun-gupta/kubernetes-java-sample/blob/master/slides/kubernetes-for-java-developers.pptx
https://docs.bitnami.com/kubernetes/how-to/configure-rbac-in-your-kubernetes-cluster/
https://supergiant.io/blog/learn-how-to-assign-pods-to-nodes-in-kubernetes-using-nodeselector-and-affinity-features/

CRIO
https://medium.com/errnothxbye/centos-7-with-cri-o-on-eks-ae9684aff764


























######################### INSTALAÇÃO ##############################

ansible -m ping kubeh
ansible -m shell -a "echo '10.1.10.108 kube01h' >> /etc/hosts" kubeh
ansible -m shell -a "echo '10.1.10.119 kube02h' >> /etc/hosts" kubeh
ansible -m shell -a "echo '10.1.10.165 kube03h' >> /etc/hosts" kubeh
ansible -m shell -a "echo '10.1.10.224 kube04h' >> /etc/hosts" kubeh
ansible -m shell -a "echo '10.1.11.140 kube05h' >> /etc/hosts" kubeh
ansible -m shell -a "echo '10.1.11.166 kube06h' >> /etc/hosts" kubeh
ansible -m shell -a "echo '10.1.12.166 kube07h' >> /etc/hosts" kubeh
ansible -m shell -a "echo '10.1.12.178 kube08h' >> /etc/hosts" kubeh

ansible -m hostname -a "name=kube01h.trf5.gov.br" kube01h
ansible -m hostname -a "name=kube02h.trf5.gov.br" kube02h
ansible -m hostname -a "name=kube03h.trf5.gov.br" kube03h
ansible -m hostname -a "name=kube04h.trf5.gov.br" kube04h
ansible -m hostname -a "name=kube05h.trf5.gov.br" kube05h
ansible -m hostname -a "name=kube06h.trf5.gov.br" kube06h
ansible -m hostname -a "name=kube07h.trf5.gov.br" kube07h
ansible -m hostname -a "name=kube08h.trf5.gov.br" kube08h

ansible -m shell -a "swapoff -a" kubeh
ansible -m replace -a "path=/etc/fstab regexp='(.*swap*)' replace='#\1'" kubeh

ansible -m shell -a "modprobe br_netfilter" kubeh
ansible -m shell -a "echo '1' > /proc/sys/net/ipv4/ip_forward" kubeh
ansible -m shell -a "echo '1' > /proc/sys/net/bridge/bridge-nf-call-iptables" kubeh
ansible -m copy -a "src=./k8s.conf.modules dest=/etc/modules-load.d/k8s.conf" kubeh
ansible -m copy -a "src=./k8s.conf.sysctl dest=/etc/sysctl.d/k8s.conf" kubeh
ansible -m shell -a "sysctl --system" kubeh

ansible -m yum -a "name=epel-release state=latest" kubeh
ansible -m yum -a "name=* state=latest" kubeh
ansible -m yum -a "name=yum-utils state=latest" kubeh
ansible -m yum -a "name=device-mapper-persistent-data state=latest" kubeh
ansible -m yum -a "name=lvm2 state=latest" kubeh
ansible -m yum -a "name=nfs-utils state=latest" kubeh

ansible -m yum -a "name=kompose state=latest" kubeh
ansible -m systemd -a "name=firewalld enabled=no state=stopped" kubeh
ansible -m copy -a "src=./kubernetes.repo dest=/etc/yum.repos.d/kubernetes.repo" kubeh
ansible -m shell -a "sed -i --follow-symlinks 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/sysconfig/selinux" kubeh
ansible -m shell -a "setenforce 0" kubeh
ansible -m yum -a "name=kubeadm state=latest" kubeh
ansible -m yum -a "name=docker state=latest" kubeh
ansible -m systemd -a "name=docker enabled=yes state=restarted" kubeh
ansible -m systemd -a "name=kubelet enabled=yes state=restarted" kubeh
ansible -m command -a "reboot" kubeh

#ansible -m firewalld -a "port=6443/tcp permanent=yes state=enabled" kubeh
#ansible -m firewalld -a "port=2379-2380/tcp permanent=yes state=enabled" kubeh
#ansible -m firewalld -a "port=10250/tcp permanent=yes state=enabled" kubeh
#ansible -m firewalld -a "port=10251/tcp permanent=yes state=enabled" kubeh
#ansible -m firewalld -a "port=10252/tcp permanent=yes state=enabled" kubeh
#ansible -m firewalld -a "port=10255/tcp permanent=yes state=enabled" kubeh
#ansible -m firewalld -a "port=8080/tcp permanent=yes state=enabled" kubeh
#ansible -m firewalld -a "port=30000-32767/tcp permanent=yes state=enabled" kubeh
#ansible -m systemd -a "name=firewalld enabled=yes state=restarted" kubeh
#ansible -m command -a "firewall-cmd --complete-reload" kubeh

######################### INSTALAÇÃO ##############################


























######################### CONFIGURAÇÃO ##############################

kubeadm init --pod-network-cidr=10.244.0.0/16 --apiserver-advertise-address=10.1.10.108

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

============================ PLUGINS DE REDE CNI ============================

DOC = https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/
Comparação dos plugins = https://rancher.com/blog/2019/2019-03-21-comparing-kubernetes-cni-providers-flannel-calico-canal-and-weave/

<<<<< FLANNEL >>>>>>
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/k8s-manifests/kube-flannel-rbac.yml
<<<<< FLANNEL >>>>>>

<<<<< CALICO >>>>>>
kubectl apply -f https://docs.projectcalico.org/v3.9/manifests/canal.yaml
DOC = https://docs.projectcalico.org/v3.9/getting-started/kubernetes/installation/flannel
<<<<< CALICO >>>>>>

============================ PLUGINS DE REDE CNI ============================

kubectl get nodes -o wide
kubectl get pods --all-namespaces
kubectl get componentstatuses
kubectl cluster-info
kubectl version --short

kubeadm token create --print-join-command

######################### CONFIGURAÇÃO ##############################



<<<<<<<<<<<<<<<< TESTES >>>>>>>>>>>>>>>>>>


kubectl create deployment --image nginx meu-nginx
kubectl scale deployment --replicas=4 meu-nginx 
kubectl expose deployment meu-nginx --port=80 --type=LoadBalancer


<<<<<<<<<<<<<<<< TESTES >>>>>>>>>>>>>>>>>>



























######################### problema ##############################

ansible -m copy -a "src=./11-cgroups.conf dest=/usr/lib/systemd/system/kubelet.service.d/11-cgroups.conf" kubeh
ansible -m file -a "path=/etc/systemd/system.conf.d/ state=directory mode='u=rwx,g=rwx,o='" kubeh
ansible -m copy -a "src=./kubernetes-accounting.conf dest=/etc/systemd/system.conf.d/kubernetes-accounting.conf" kubeh
ansible -m systemd -a "daemon_reload=yes" kubeh
ansible -m systemd -a "name=kubelet enabled=yes state=restarted" kubeh


solução
https://github.com/kubernetes/kops/issues/4049
https://github.com/kubernetes/kubernetes/issues/56850


Troubleshooting
https://medium.com/appvia/prevent-resource-starvation-of-critical-system-and-kubernetes-services-83cfeaa6ac96
https://medium.com/@cagri.ersen/kubernetes-metrics-server-installation-d93380de008


######################### problema ##############################


























######################### metric server ##############################

https://medium.com/@cagri.ersen/kubernetes-metrics-server-installation-d93380de008

site = https://github.com/kubernetes-incubator/metrics-server
git clone https://github.com/kubernetes-incubator/metrics-server

alterar no arquivo metrics-server-deployment.yaml

vim metrics-server/deploy/1.8+/metrics-server-deployment.yaml

      - name: metrics-server
        image: k8s.gcr.io/metrics-server-amd64:v0.3.1
        command:
          - /metrics-server
          - --metric-resolution=5s
          - --kubelet-preferred-address-types=InternalIP
          - --kubelet-insecure-tls
        imagePullPolicy: Always
        volumeMounts:
        - name: tmp-dir
          mountPath: /tmp


kubectl create -f metrics-server/deploy/1.8+/
kubectl top nodes
kubectl top pods

<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

solução 2:
site = https://stackoverflow.com/questions/52860209/kubernetes-1-11-could-not-find-heapster-for-metrics
git clone https://github.com/kodekloudhub/kubernetes-metrics-server.git
kubectl create -f kubernetes-metrics-server/
kubectl top nodes
kubectl top pods

######################### metric server ##############################


























######################### LINKS ##############################
https://medium.com/faun/production-grade-kubernetes-monitoring-using-prometheus-78144b835b60
https://github.com/Thakurvaibhav/k8s/blob/master/monitoring/prometheus/03-prometheus-storage.yaml
https://github.com/vevsatechnologies/Install-Kubernetes-on-CentOs
https://www.replex.io/blog/how-to-install-access-and-add-heapster-metrics-to-the-kubernetes-dashboard
https://www.linuxtechi.com/install-kubernetes-1-7-centos7-rhel7/
https://www.linuxtips.io/post/kubernetes-sem-docker
https://www.linuxtips.io/post/descomplicando-o-kubernetes-03
http://devopslab.com.br/kubernetes-como-instalar-e-configurar-o-kubernetes-k8s-gerencia-de-containers-docker/
https://www.server-world.info/en/note?os=CentOS_7&p=kubernetes&f=5
######################### LINKS ##############################

























############################ DASHBOARD ############################

OFICIAL -> https://kubernetestutorials.com/how-to-install-kubernetes-dashboard/

[INSEGURO]
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v1.10.0/src/deploy/alternative/kubernetes-dashboard.yaml

[RECOMENDADO]
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v1.10.1/src/deploy/recommended/kubernetes-dashboard.yaml

kubectl create serviceaccount dashboard -n default
kubectl create clusterrolebinding dashboard-admin -n default --clusterrole=cluster-admin --serviceaccount=default:dashboard
kubectl get secret $(kubectl get serviceaccount dashboard -o jsonpath="{.secrets[0].name}") -o jsonpath="{.data.token}" | base64 --decode


kubectl apply -f https://raw.githubusercontent.com/kubernetes/kubernetes/master/cluster/addons/cluster-monitoring/influxdb/influxdb-service.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes/kubernetes/master/cluster/addons/cluster-monitoring/influxdb/heapster-service.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes/kubernetes/master/cluster/addons/cluster-monitoring/influxdb/influxdb-grafana-controller.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes/kubernetes/master/cluster/addons/cluster-monitoring/influxdb/heapster-controller.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes/kubernetes/master/cluster/addons/cluster-monitoring/influxdb/grafana-service.yaml

grafana + influxdb
https://logz.io/blog/kubernetes-monitoring/
kibana
https://imti.co/kibana-kubernetes/
elasticsearch
https://portworx.com/run-ha-elasticsearch-elk-azure-kubernetes-service/

############################ DASHBOARD ############################


























############################ MONITORAMENTO ############################
https://github.com/coreos/kube-prometheus

git clone https://github.com/coreos/kube-prometheus.git
kubectl create -f kube-prometheus/manifests/

############################ MONITORAMENTO ############################


























############################ INGRESS NGINX ############################
https://devopscube.com/kubernetes-ingress-tutorial/
https://devopscube.com/setup-ingress-kubernetes-nginx-controller/

kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/static/mandatory.yaml

ansible -m copy -a "src=./ingress-nginx dest=/root/" kube01h

kubectl create -f ingress-nginx/

kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/namespace.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/default-backend.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/configmap.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/tcp-services-configmap.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/udp-services-configmap.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/rbac.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/without-rbac.yaml

############################ INGRESS NGINX ############################


























############################ INGRESS HAPROXY ############################

https://www.haproxy.com/blog/dissecting-the-haproxy-kubernetes-ingress-controller/

kubectl apply -f https://raw.githubusercontent.com/haproxytech/kubernetes-ingress/master/deploy/haproxy-ingress.yaml

adicionar endereços IP dos load balancers

  externalIPs:
  - 10.1.10.108
  - 10.1.10.119
  - 10.1.10.165
  - 10.1.10.224
  - 10.1.11.140
  - 10.1.11.166
  - 10.1.12.166
  - 10.1.12.178
############################ INGRESS HAPROXY ############################

  
