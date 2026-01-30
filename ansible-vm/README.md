# Ansible Playbook - Remote Server Configuration

This Ansible playbook configures a remote server by:
- Adding a new user
- Configuring SSH public key
- Assigning user to sudo/wheel and docker groups

## Requirements

- Ansible installed locally
- Access to remote server (user with sudo privileges)
- SSH public key to add

## Configuration

### 1. Edit the playbook

Open the `ansible-playbook.yml` file and set the variables:
- `new_username`: Username to create
- `new_user_ssh_key`: Your SSH public key (from `~/.ssh/id_rsa.pub` or similar)

### 2. Configure inventory

Edit the `inventory.ini` file and add information about the remote server:

```ini
[servers]
remote_server ansible_host=SERVER_IP ansible_user=ADMIN_USER ansible_password=PASSWORD
```

**NOTE**: For security, it's better to use `ansible-vault` to encrypt passwords or SSH keys.

### 3. Alternatively - use environment variables

You can also pass data directly in the command:

```bash
ansible-playbook ansible-playbook.yml \
  -i SERVER_IP, \
  -e "ansible_user=ADMIN_USER" \
  -e "ansible_ssh_pass=PASSWORD" \
  -e "new_username=your_username" \
  -e "new_user_ssh_key='$(cat ~/.ssh/id_rsa.pub)'"
```

## Running

### Method 1: With inventory file

```bash
ansible-playbook ansible-playbook.yml -i inventory.ini
```

### Method 2: Directly with IP address

```bash
ansible-playbook ansible-playbook.yml \
  -i "SERVER_IP," \
  -e "ansible_user=ADMIN_USER" \
  -e "ansible_ssh_pass=PASSWORD" \
  -e "ansible_become_pass=SUDO_PASSWORD" \
  -e "new_username=your_username" \
  -e "new_user_ssh_key='$(cat ~/.ssh/id_rsa.pub)'"
```

### Method 3: Using ansible-vault (recommended)

First, create an encrypted file with passwords:

```bash
ansible-vault create group_vars/servers/vault.yml
```

Add to it:
```yaml
ansible_password: your_password
ansible_become_pass: your_sudo_password
```

Then run:
```bash
ansible-playbook ansible-playbook.yml -i inventory.ini --ask-vault-pass
```

## Security

⚠️ **IMPORTANT**: 
- Never commit files with passwords to Git repository
- Use `ansible-vault` to encrypt sensitive data
- Consider using SSH keys instead of passwords for server connection

## Verification

After running the playbook, you can verify if everything works:

```bash
# Connect to server as new user
ssh your_username@SERVER_IP

# Check user groups
groups

# Check sudo permissions
sudo -l

# Check docker access
docker ps
```
