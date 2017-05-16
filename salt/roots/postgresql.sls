postgresql:
  # to get the latest postgresql.
  pkgrepo.managed:
    - name: deb http://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main
    - file: /etc/apt/sources.list.d/pgdg.list
    - key_url: https://www.postgresql.org/media/keys/ACCC4CF8.asc
  pkg.installed:
    - names:
      - libpq-dev
      - postgresql-9.6
      - postgresql-contrib-9.6
  service.running:
    - enable: True
    - require:
        - pkg: postgresql
