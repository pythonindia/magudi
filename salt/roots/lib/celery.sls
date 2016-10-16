{% set name = pillar['service']['name'] %}

broker:
  pkg.installed:
    - names:
      - redis-server

/etc/init/{{name}}_celery.conf:
  file.managed:
    - source: salt://lib/files/celery.conf.j2
    - template: jinja
    - defaults:
        name: "{{name}}"
    - user: app

{{name}}_celery:
  service.running:
    - require:
      - pkg: broker
      - file: /etc/init/{{name}}_celery.conf
      - cmd: /opt/envs/{{name}}/bin/python manage.py migrate
    - watch:
      - file: /etc/init/{{name}}_celery.conf
      - file: /opt/{{name}}/settings/prod.py
      - git: {{name}}_code
