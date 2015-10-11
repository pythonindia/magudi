/etc/nginx/sites-available/pythonexpress.in.conf:
  file.managed:
    - source: salt://pythonexpressin/pythonexpress.in.conf
    - template: jinja

/etc/nginx/sites-enabled/pythonexpress.in.conf:
  file.symlink:
    - target: /etc/nginx/sites-available/pythonexpress.in.conf
