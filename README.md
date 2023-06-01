# Xray Ansible Role

An Ansible Role to deploy different [Xray](https://github.com/XTLS/Xray-corex) setups along with Nginx and [WARP](https://cloudflarewarp.com/) on Linux (Tested on Debian and Ubuntu)
These are what's included:
* [3x-ui](https://github.com/MHSanaei/3x-ui)
* [marzban](https://github.com/Gozargah/Marzban)
* [WARP](https://cloudflarewarp.com/)

## Role Variables

Available variables are listed below:

    certbot_admin_email: Domain-Maintainer@mail.com
    certbot_create_method: standalone
    certbot_create_if_missing: true
    certbot_certs:
    - domains:
        - example.com
    - domains:
        - example2.com

    xray_log_level: warning
    trojan_shadowsocks_password: TORJAN_SHADOWSOCKS_INBOUNDS_PASSWORD
    vless_vmess_uuid: 7730e289-a907-4d89-82c5-b73d26d98aea
    subscription_filename: mysub

    xray_domains:
    - example.com
    - example2.com

## Requirements

- [certbot](https://galaxy.ansible.com/geerlingguy/certbot/) is used to get certificates for the given domains.

- [docker](https://galaxy.ansible.com/geerlingguy/docker/) is used to deploy panels.

They can be installed with the following command(provided that ansible-galaxy is already installed and available):

```
ansible-galaxy install -r requirements.yml
```

- an A type DNS record of the given domain should point to the public IP adress of the server

## Example

### playbook.yml

```yaml
- name: Setup Xray server
  hosts:
    - xray
  become: true
  vars:
    # Certbot
    certbot_admin_email: domain-maintainer@mail.com
    certbot_create_method: standalone
    certbot_create_if_missing: true
    certbot_certs:
      - domains:
          - example.com
      - domains:
          - example2.com

    # Xray
    xray_log_level: warning
    trojan_shadowsocks_password: TORJAN_SHADOWSOCKS_INBOUNDS_PASSWORD
    vless_vmess_uuid: 7730e289-a907-4d89-82c5-b73d26d98aea
    subscription_filename: subs

    xray_domains:
      - example.com
      - example2.com

  roles:
    - fetch_public_ips
    - geerlingguy.certbot
    - xray_nginx
    - warp
```

### inventory.yml

```yaml
all:
  hosts:
    xray:
      ansible_host: x.x.x.x # Server public IP
      ansible_user: root
      ansible_ssh_private_key_file: ~/.ssh/id_rsa # The ssh-key that is already added to server
```

### running the playbook

```bash
ansible-playbook -i inventory.yml playbook.yml
```
