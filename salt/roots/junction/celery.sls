{% set name = pillar['service']['name'] %}

broker:
  pkg.installed:
    - names:
      - redis-server

/etc/systemd/system/{{name}}_celery.service:
  file.managed:
    - source: salt://junction/files/celery.conf.j2
    - template: jinja
    - defaults:
        name: "{{name}}"
    - user: app

{{name}}_celery:
  service.running:
    - enable: True
    - require:
      - pkg: broker
      - file: /etc/systemd/system/{{name}}_celery.service
      - cmd: migrate_{{name}}
    - watch:
      - file: /etc/systemd/system/{{name}}_celery.service
      - file: /opt/{{name}}/settings/prod.py
      - git: {{name}}_code
