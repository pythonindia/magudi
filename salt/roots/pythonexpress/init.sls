{% set ssl = pillar['pythonexpress']['ssl'] %}

/var/www/html/pythonexpress.org/:
  file.directory

/etc/nginx/sites-available/pythonexpress.org.conf:
  file.managed:
    - source: salt://pythonexpressin/pythonexpress.org.conf
    - template: jinja
    - require:
        - file: nginx_config_folders
    - defaults:
      ssl: {{ ssl }}

/etc/nginx/sites-available/beta.pythonexpress.in.conf:
  file.managed:
    - source: salt://pythonexpressin/beta.pythonexpress.in.conf
    - template: jinja
    - require:
        - file: nginx_config_folders

/etc/nginx/sites-enabled/pythonexpress.org.conf:
  file.symlink:
    - target: /etc/nginx/sites-available/pythonexpress.org.conf
    - require:
        - file: /etc/nginx/sites-available/pythonexpress.org.conf

/etc/nginx/sites-enabled/beta.pythonexpress.in.conf:
  file.symlink:
    - target: /etc/nginx/sites-available/beta.pythonexpress.in.conf
    - require:
        - file: /etc/nginx/sites-available/beta.pythonexpress.in.conf

nginx_pythonexpress_dir:
  file.directory:
    - names:
        - /etc/nginx/sites-available/pythonexpress.org/
        - /etc/nginx/sites-available/pythonexpress.org/upstreams/
    - require:
        - file: nginx_config_folders

{% if ssl['on'] %}
/etc/ssl/pythonexpress.org.crt:
  file.managed:
    - contents_pillar: pythonexpress:ssl:cert

/etc/ssl/pythonexpress.org.key:
  file.managed:
    - contents_pillar: pythonexpress:ssl:key

/etc/nginx/sites-available/pythonexpress.org.with_ssl.conf:
  file.managed:
    - source: salt://pythonexpressin/pythonexpress.org.with_ssl.conf

{% endif %}
