/usr/lib/systemd/system/junction.service:
  file.managed:
    - source: salt://junction/files/junction.conf.j2
    - user: app

/etc/sysconfig/junction:
  file.managed:
    - source: salt://junction/files/junction.env
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
    - require:
        - file: nginx_inpycon_dir

/etc/nginx/sites-available/upstreams/junction_upstream.conf:
  file.managed:
    - source: salt://junction/files/junction_upstream.conf
    - require:
        - file: nginx_config_folders
