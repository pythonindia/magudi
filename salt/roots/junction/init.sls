special_dirs:
  file.directory:
    - user: app
    - group: app
    - names:
      - /opt/junction
      - /opt/envs
      - /var/run/uwsgi

include:
  - junction/code
  - junction/db
  - junction/uwsgi
  - junction/service
