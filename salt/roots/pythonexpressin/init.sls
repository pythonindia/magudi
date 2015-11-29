{% set ssl = pillar['pythonexpress']['ssl'] %}

/etc/nginx/sites-available/pythonexpress.in.conf:
  file.managed:
    - source: salt://pythonexpressin/pythonexpress.in.conf
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
        - /etc/nginx/sites-available/pythonexpress.in/
        - /etc/nginx/sites-available/pythonexpress.in/upstreams/
    - require:
        - file: nginx_config_folders

{% if ssl['on'] %}
/etc/ssl/pythonexpress.in.crt:
  file.managed:
    - contents_pillar: pythonexpress:ssl:cert

/etc/ssl/pythonexpress.in.key:
  file.managed:
    - contents_pillar: pythonexpress:ssl:key

/etc/nginx/sites-available/pythonexpress.in.with_ssl.conf:
  file.managed:
    - source: salt://pythonexpressin/pythonexpress.in.with_ssl.conf

{% endif %}
