postgres:
  pkg.installed:
    - names:
      - postgresql
      - postgresql-contrib
  service.running:
    - require:
        - pkg: postgres
