/etc/init/junction.conf:
  file.managed:
    - source: salt://junction/files/junction.conf.j2
    - user: app

junction:
  service.running:
    - require:
      - file: /etc/init/junction.conf
      - file: /etc/uwsgi/junction.ini
      - pip: uwsgi
    - reload: True
    - watch:
      - file: /etc/init/junction.conf
      - file: /etc/uwsgi/junction.ini
      - file: /opt/junction/settings/prod.py
      - git: junction_code

/etc/nginx/sites-available/in.pycon.org/cfp.conf:
  file.managed:
    - source: salt://junction/files/cfp.conf.j2

/etc/nginx/sites-available/upstreams/junction_upstream.conf:
  file.managed:
    - source: salt://junction/files/junction_upstream.conf
