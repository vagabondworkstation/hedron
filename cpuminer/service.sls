# Mode 0400 since this includes a wallet address which is a unique identifier.
# Although it can still be read through systemd... meh.
hedron_cpuminer_service_file:
  file.managed:
    - name: /etc/systemd/system/cpuminer.service
    - source: salt://hedron/cpuminer/files/cpuminer.service.jinja
    - template: jinja
    - mode: 0400
    - check_cmd: systemd-analyze verify
    - tmp_ext: .service


hedron_cpuminer_service_running:
  service.running:
   - name: cpuminer
   - enable: True
   - watch:
     - file: /etc/systemd/system/cpuminer.service
