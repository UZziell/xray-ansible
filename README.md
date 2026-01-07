# Proxy Ansible

A collection of Ansible Roles to deploy different proxies([Xray](https://github.com/XTLS/Xray-corex), Sing-box) along with Nginx and [WARP](https://cloudflarewarp.com/) on Linux (Tested on Debian and Ubuntu)

Currently maintained roles:
<!-- * [3x-ui](https://github.com/MHSanaei/3x-ui) -->
<!-- * [marzban](https://github.com/Gozargah/Marzban) -->
* WARP
* initial_configuration

<!-- ## Requirements

- [certbot](https://galaxy.ansible.com/geerlingguy/certbot/) is used to get certificates for the given domains.

- [docker](https://galaxy.ansible.com/geerlingguy/docker/) is used to deploy panels.

They can be installed with the following command(provided that ansible-galaxy is already installed and available):

```
ansible-galaxy install -r requirements.yml
```

- an A type DNS record of the given domain should point to the public IP adress of the server -->

## How to use
1. Create `inventory.yaml` from template

    Copy `inventory.yaml.example` to `inventory.yaml` and replace **ansible_host** and **server credentials** with proper values.

2. Create `initial_configuration.yaml` playbook from template

    Copy `playbooks/initial_configuration.yaml.example` to `playbooks/initial_configuration.yaml`. Add/change variables based on the defaults [roles/initial_configuration/defaults/main.yml](roles/initial_configuration/defaults/main.yml).
    Also ensure to set the `initial_password_salt` variable which is used to set password for created users.

3. Finally, run the playbook

```bash
ansible-playbook -i inventory.yaml playbooks/initial_configuration.yaml
```
