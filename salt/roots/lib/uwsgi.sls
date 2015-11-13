{% macro uwsgi(name, server_config) -%}
{{name}}_uwsgi:
  pip.installed:
    - name: uwsgi
    - require:
      - virtualenv: /opt/envs/{{name}}
    - bin_env: /opt/envs/{{name}}
    - user: app

/etc/uwsgi/{{name}}.ini:
  file.managed:
    - source: salt://lib/files/uwsgi_config.ini
    - user: app
    - template: jinja
    - require:
      - file: uwsgi_dirs
    - defaults:
      service_name: {{name}}
      config: {{server_config}}
{% endmacro %}
