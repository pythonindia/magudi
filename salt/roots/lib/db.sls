{% macro database(name, db) -%}
{{name}}_database:
  postgres_user.present:
    - user: postgres
    - name: {{ db['user'] }}
    - password: {{ db['password'] }}
    - require:
      - service: postgresql

  postgres_database.present:
    - name: {{ db['name'] }}
    - encoding: UTF8
    - lc_ctype: en_US.UTF8
    - lc_collate: en_US.UTF8
    - template: template0
    - owner: {{ db['user'] }}
    - user: postgres
    - require:
      - postgres_user: {{name}}
{% endmacro %}
