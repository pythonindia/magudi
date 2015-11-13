/etc/nginx/sites-available/pythonexpress.in.conf:
  file.managed:
    - source: salt://pythonexpressin/pythonexpress.in.conf
    - template: jinja
    - require:
        - file: nginx_config_folders

/etc/nginx/sites-enabled/pythonexpress.in.conf:
  file.symlink:
    - target: /etc/nginx/sites-available/pythonexpress.in.conf
    - require:
        - file: nginx_config_folders
        - file: /etc/nginx/sites-available/pythonexpress.in.conf
