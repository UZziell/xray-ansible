# Xray Ansible Role

An Ansible Role that installs [Xray](https://github.com/XTLS/Xray-corex), Nginx and [WARP](https://cloudflarewarp.com/) on Linux (Tested on Debian and Ubuntu)


## Role Variables

Available variables are listed below:

    certbot_admin_email: Domain-Maintainer@mail.com
    certbot_create_method: standalone
    certbot_create_if_missing: true
    certbot_create_standalone_stop_services: []
    certbot_certs:
    - domains:
        - example.com
    - domains:
        - example2.com

    XRAY_LOG_LEVEL: warning
    TROJAN_SHADOWSOCKS_PASSWORD: TORJAN_SHADOWSOCKS_INBOUNDS_PASSWORD
    VLESS_VMESS_UUID: 7730e289-a907-4d89-82c5-b73d26d98aea

    DOMAINS:
    - example.com
    - example2.com


## Requirements

[certbot](https://galaxy.ansible.com/geerlingguy/certbot/) role is used to get certificates for the given domains. It should be installed with the following command:
```
ansible-galaxy install -r requirements.yml
```

## Example Playbook

```yaml
- name: Setup Xray server
  hosts:
    - xray
  become: true
  vars:
    certbot_admin_email: Domain-Maintainer@mail.com
    certbot_create_method: standalone
    certbot_create_if_missing: true
    certbot_create_standalone_stop_services: []
    certbot_certs:
    - domains:
        - example.com
    - domains:
        - example2.com

    XRAY_LOG_LEVEL: warning
    TROJAN_SHADOWSOCKS_PASSWORD: TORJAN_SHADOWSOCKS_INBOUNDS_PASSWORD
    VLESS_VMESS_UUID: 7730e289-a907-4d89-82c5-b73d26d98aea

    DOMAINS:
    - example.com
    - example2.com

  roles:
    - geerlingguy.certbot
    - xray_nginx
    - warp

```
