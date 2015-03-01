{% set db = pillar['junction']['db'] %}
junction_database:
  postgres_user.present:
    - name: {{ db['user'] }}
    - password: {{ db['password'] }}
    - runas: postgres
    - require:
      - service: postgresql

  postgres_database.present:
    - name: {{ db['name'] }}
    - encoding: UTF8
    - lc_ctype: en_US.UTF8
    - lc_collate: en_US.UTF8
    - template: template0
    - owner: {{ db['user'] }}
    - runas: postgres
    - require:
      - postgres_user: junction
