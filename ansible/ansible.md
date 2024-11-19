# Setup Ansible

1. Install ansibe on Ubuntu 22.04

   ```sh
   sudo apt update
   sudo apt install software-properties-common
   sudo add-apt-repository --yes --update ppa:ansible/ansible
   sudo apt install ansible
   ```

2. Add Jenkins master and slave as hosts
   Add jenkins master and slave private IPs in the inventory file
   in this case, we are using /opt is our working directory for Ansible.

   ```
    [jenkins-master]
    10.0.1.7
    [jenkins-master:vars]
    ansible_user=adminuser
    ansible_ssh_private_key_file=/home/adminuser/private_key.pem

    [jenkins-slave]
    10.0.1.9

    [jenkins-slave:vars]
    ansible_user=adminuser
    ansible_ssh_private_key_file=/home/adminuser/private_key.pem
   ```

3. Test the connection

   ```sh
   ansible -i hosts all -m ping
   ```

4. install:

```
ansible-playbook -i hosts jenkins-master-setup.yaml --check
```

```
ansible-playbook -i hosts jenkins-master-setup.yaml
ansible-playbook -i hosts v2-jenkins-slave-setup.yaml
```
