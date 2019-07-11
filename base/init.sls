include:
  - .salt
  - .bash
  - .hostname
  - .timezone
  - hedron.networking.resolv_conf
  - hedron.sshd
  - hedron.users
  - .disable_cron
  - .purge
  - hedron.systemd
  - hedron.baremetal
  - hedron.serial

# For security reasons, /var/log/installer should not be world-readable.
hedron_base_installer_log_directory_permissions:
  file.directory:
    - name: /var/log/installer
    - mode: 0700

hedron_base_kill_networkmanager:
  service.dead:
    - name: NetworkManager
    - enable: False

hedron_base_tmp_tmpfs:
  mount.mounted:
    - name: /tmp
    - device: tmpfs
    - fstype: tmpfs

hedron_base_proc_restrictions:
  mount.mounted:
    - name: /proc
    - device: proc
    - fstype: proc
    - opts: nosuid,nodev,noexec,hidepid=2

# Remove these. If install fails and you retry, it can install extra packages that cause problems.
hedron_base_packages_purged:
  pkg.purged:
    - pkgs:
      - network-manager
      - gnome-terminal
      - console-setup-linux

# Install these on all systems.

# gnupg2 is for apt-key add on Debian 10

hedron_base_packages:
  pkg.installed:
    - pkgs:
      - bridge-utils
      - rsync
      - bwm-ng
      - tcpdump
      - ccrypt
      - htop
      - strace
      - curl
      - arping
      - pwgen
      - pv
      - uuid-runtime
      - dtach
      - psmisc
      - virt-what
      - dc
      - ldnsutils
      - socat
      - whois
      - sysstat
      - ndisc6
      - mtr-tiny
      - bind9-host
      - gnupg2

hedron_base_var_empty:
  file.directory:
    - name: /var/empty
