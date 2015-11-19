{% set name = 'wye' %}

{{pillar["wye"]["media_root"]}}:
  file.directory:
    - user: app
    - makedirs: True

/etc/init/{{name}}.conf:
  file.managed:
    - source: salt://{{name}}/files/{{name}}.conf.j2
    - user: app

{{name}}:
  service.running:
    - require:
      - file: /etc/init/{{name}}.conf
      - file: /etc/uwsgi/{{name}}.ini
      - file: {{pillar["wye"]["media_root"]}}
      - pip: uwsgi
      - cmd: /opt/envs/{{name}}/bin/python manage.py migrate
    - reload: True
    - watch:
      - file: /etc/init/{{name}}.conf
      - file: /etc/uwsgi/{{name}}.ini
      - file: /opt/{{name}}/settings/prod.py
      - git: {{name}}_code

pythonexpress_nginx_dirs:
  file.directory:
    - names:
        - /etc/nginx/sites-available/beta.pythonexpress.in/
        - /etc/nginx/sites-available/beta.pythonexpress.in/upstreams/
    - require:
        - file: nginx_pythonexpress_dir

/etc/nginx/sites-available/beta.pythonexpress.in/express.conf:
  file.managed:
    - source: salt://{{name}}/files/express.conf.j2
    - require:
        - file: nginx_pythonexpress_dir
    - template: jinja

/etc/nginx/sites-available/beta.pythonexpress.in/upstreams/{{name}}_upstream.conf:
  file.managed:
    - source: salt://{{name}}/files/{{name}}_upstream.conf.j2
    - require:
        - file: nginx_pythonexpress_dir
    - template: jinja
    - defaults:
      http_port: {{pillar[name]['server_config']['port']}}
