#!/bin/bash

dnf install ansible -y
cd /tmp
git clone https://github.com/kanth-sri/expense-ansible.git
cd expense-ansible

ansible-playbook -i inventory.ini mysql-deploy.yaml
ansible-playbook -i inventory.ini backend.yaml
ansible-playbook -i inventory.ini web.yaml