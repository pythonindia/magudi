uwsgi_dirs:
  file.directory:
    - names:
        - /etc/uwsgi
        - /var/log/uwsgi
        - /var/run/uwsgi
        - /opt/envs
    - user: app
