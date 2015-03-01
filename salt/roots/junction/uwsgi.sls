uwsgi:
  pip.installed:
    - require:
      - virtualenv: /opt/envs/junction
    - bin_env: /opt/envs/junction
    - user: app

uwsgi_dirs:
  file.directory:
    - names:
        - /etc/uwsgi
        - /var/log/uwsgi
    - user: app

/etc/uwsgi/junction.ini:
  file.managed:
    - source: salt://junction/files/config.ini
    - user: app
