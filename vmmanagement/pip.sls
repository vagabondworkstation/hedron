# pip dependencies for hedron.vmmanagement

include:
  - hedron.pip.python3
  - hedron.walkingliberty

# python3-nacl is for paramiko to help make build easier. Otherwise needs python3-dev, most likely.
hedron_vmmanagement_pip_apt_packages:
  pkg.installed:
    - pkgs:
      - python3-nacl

# bitcoinacceptor is for vmmanagement_create.py
hedron_vmmanagement_pip_dependencies:
  pip.installed:
    - pkgs:
      - paramiko
      - bitcoinacceptor>=0.4.5
      - pytest
      - hug
      - requests
      - statsd
      - sshpubkeys
      - ipxeplease
    - bin_env: /usr/bin/pip3
