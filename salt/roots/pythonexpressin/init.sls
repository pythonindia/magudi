/etc/nginx/sites-available/pythonexpress.in.conf:
  file.managed:
    - source: salt://pythonexpressin/pythonexpress.in.conf
    - template: jinja
