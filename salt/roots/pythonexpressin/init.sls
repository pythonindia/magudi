/etc/nginx/sites-available/pythonexpress.in.conf:
  file.managed:
    - source: salt://pythonexpressin/pythonexpress.in.conf
    - template: jinja
    - require:
        - file: nginx_config_folders

/etc/nginx/sites-available/beta.pythonexpress.in.conf:
  file.managed:
    - source: salt://pythonexpressin/beta.pythonexpress.in.conf
    - template: jinja
    - require:
        - file: nginx_config_folders

/etc/nginx/sites-enabled/pythonexpress.in.conf:
  file.symlink:
    - target: /etc/nginx/sites-available/pythonexpress.in.conf
    - require:
        - file: /etc/nginx/sites-available/pythonexpress.in.conf

/etc/nginx/sites-enabled/beta.pythonexpress.in.conf:
  file.symlink:
    - target: /etc/nginx/sites-available/beta.pythonexpress.in.conf
    - require:
        - file: /etc/nginx/sites-available/beta.pythonexpress.in.conf

nginx_pythonexpress_dir:
  file.directory:
    - names:
        - /etc/nginx/sites-available/beta.pythonexpress.in/
        - /etc/nginx/sites-available/beta.pythonexpress.in/upstreams/
    - require:
        - file: nginx_config_folders
