# Ansible Playbook - Konfiguracja zdalnego serwera

Ten playbook Ansible konfiguruje zdalny serwer poprzez:
- Dodanie nowego użytkownika
- Skonfigurowanie klucza publicznego SSH
- Przypisanie użytkownika do grup sudo/wheel i docker

## Wymagania

- Ansible zainstalowany lokalnie
- Dostęp do zdalnego serwera (użytkownik z uprawnieniami sudo)
- Klucz publiczny SSH do dodania

## Konfiguracja

### 1. Edytuj playbook

Otwórz plik `ansible-playbook.yml` i ustaw zmienne:
- `new_username`: Nazwa użytkownika do utworzenia
- `new_user_ssh_key`: Twój klucz publiczny SSH (z pliku `~/.ssh/id_rsa.pub` lub podobnego)

### 2. Skonfiguruj inventory

Edytuj plik `inventory.ini` i dodaj informacje o zdalnym serwerze:

```ini
[servers]
remote_server ansible_host=IP_SERWERA ansible_user=ADMIN_USER ansible_password=HASLO
```

**UWAGA**: Dla bezpieczeństwa lepiej użyć `ansible-vault` do szyfrowania haseł lub kluczy SSH.

### 3. Alternatywnie - użyj zmiennych środowiskowych

Możesz też przekazać dane bezpośrednio w komendzie:

```bash
ansible-playbook ansible-playbook.yml \
  -i IP_SERWERA, \
  -e "ansible_user=ADMIN_USER" \
  -e "ansible_ssh_pass=HASLO" \
  -e "new_username=twoj_uzytkownik" \
  -e "new_user_ssh_key='$(cat ~/.ssh/id_rsa.pub)'"
```

## Uruchomienie

### Metoda 1: Z plikiem inventory

```bash
ansible-playbook ansible-playbook.yml -i inventory.ini
```

### Metoda 2: Bezpośrednio z adresem IP

```bash
ansible-playbook ansible-playbook.yml \
  -i "IP_SERWERA," \
  -e "ansible_user=ADMIN_USER" \
  -e "ansible_ssh_pass=HASLO" \
  -e "ansible_become_pass=HASLO_SUDO" \
  -e "new_username=twoj_uzytkownik" \
  -e "new_user_ssh_key='$(cat ~/.ssh/id_rsa.pub)'"
```

### Metoda 3: Z użyciem ansible-vault (zalecane)

Najpierw utwórz zaszyfrowany plik z hasłami:

```bash
ansible-vault create group_vars/servers/vault.yml
```

Dodaj do niego:
```yaml
ansible_password: twoje_haslo
ansible_become_pass: twoje_haslo_sudo
```

Następnie uruchom:
```bash
ansible-playbook ansible-playbook.yml -i inventory.ini --ask-vault-pass
```

## Bezpieczeństwo

⚠️ **WAŻNE**: 
- Nigdy nie commituj plików z hasłami do repozytorium Git
- Używaj `ansible-vault` do szyfrowania wrażliwych danych
- Rozważ użycie kluczy SSH zamiast haseł dla połączenia z serwerem

## Sprawdzenie

Po uruchomieniu playbooka możesz sprawdzić czy wszystko działa:

```bash
# Połącz się z serwerem jako nowy użytkownik
ssh twoj_uzytkownik@IP_SERWERA

# Sprawdź grupy użytkownika
groups

# Sprawdź uprawnienia sudo
sudo -l

# Sprawdź dostęp do dockera
docker ps
```
