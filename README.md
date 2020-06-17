# Install kubernetes with ansible playbooks on CENTOS7-Minimal

- Ajuste as variáveis no arquivo hosts

	<code>
	K8S_MASTER_NODE_IP= [ endereço ip do master ] 
	</code>

- ansible-playbook -i hosts main.yml

