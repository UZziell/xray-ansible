# Xray Ansible Role

An Ansible Role that installs [Xray](https://github.com/XTLS/Xray-corex), Nginx and [WARP](https://cloudflarewarp.com/) on Linux (Tested on Debian and Ubuntu)


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

    XRAY_LOG_LEVEL: warning
    TROJAN_SHADOWSOCKS_PASSWORD: TORJAN_SHADOWSOCKS_INBOUNDS_PASSWORD
    VLESS_VMESS_UUID: 7730e289-a907-4d89-82c5-b73d26d98aea
    SUBSCRIPTION_FILENAME: mysub

    DOMAINS:
    - example.com
    - example2.com


## Requirements

* [certbot](https://galaxy.ansible.com/geerlingguy/certbot/) role is used to get certificates for the given domains. It should be installed with the following command:
```
ansible-galaxy install -r requirements.yml
```

* an A type DNS record of the given domain should point to the public IP adress of the server 

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
    XRAY_LOG_LEVEL: warning
    TROJAN_SHADOWSOCKS_PASSWORD: TORJAN_SHADOWSOCKS_INBOUNDS_PASSWORD
    VLESS_VMESS_UUID: 7730e289-a907-4d89-82c5-b73d26d98aea
    SUBSCRIPTION_FILENAME: subs

    DOMAINS:
    - example.com
    - example2.com

  roles:
    - extract_public_ips
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