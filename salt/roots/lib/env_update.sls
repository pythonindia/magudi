{% macro env_update(name) -%}
migrate_{{name}}:
  cmd.run:
    - name: /opt/envs/{{name}}/bin/python manage.py migrate
    - cwd: /opt/{{name}}
    - require:
      - pip: {{name}}_pip_requirements
      - file: /opt/{{name}}/settings/prod.py
      - postgres_database: {{name}}_database
    - user: app

collectstatic_{{name}}:
  cmd.run:
    - name: /opt/envs/{{name}}/bin/python manage.py collectstatic --noinput
    - cwd: /opt/{{name}}
    - require:
      - virtualenv: /opt/envs/{{name}}
      - file: /opt/{{name}}/settings/prod.py
    - user: app
{% endmacro %}
