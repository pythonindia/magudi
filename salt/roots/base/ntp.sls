ntp:
  pkg.installed: []
  service.running:
    - require:
      - pkg:
          ntp
      - file: /etc/ntp.conf
    - watch:
      - file: /etc/ntp.conf

/etc/ntp.conf:
  file.managed:
    - source: salt://base/ntp.conf
