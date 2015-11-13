{% macro env_update(name) -%}
/opt/envs/{{name}}/bin/python manage.py migrate:
  cmd.run:
    - cwd: /opt/{{name}}
    - require:
      - pip: {{name}}_pip_requirements
      - file: /opt/{{name}}/settings/prod.py
      - postgres_database: {{name}}_database
    - user: app

/opt/envs/{{name}}/bin/python manage.py collectstatic --noinput:
  cmd.run:
    - cwd: /opt/{{name}}
    - require:
      - virtualenv: /opt/envs/{{name}}
      - file: /opt/{{name}}/settings/prod.py
    - user: app
{% endmacro %}
