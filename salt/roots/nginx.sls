nginx:
  pkgrepo.managed:
    - ppa: nginx/stable
  pkg.installed:
    - refresh: True
  service.running:
    - require:
      - pkg:
          nginx
    - reload: True
    - watch:
      - file: /etc/nginx/nginx.conf
      - file: /etc/nginx/sites-available/*
      - file: /etc/nginx/sites-enabled/*

nginx_config_folders:
  file.directory:
    - names:
        - /etc/nginx/sites-enabled/
        - /etc/nginx/sites-available/
        - /etc/nginx/sites-available/upstreams
    - require:
        - pkg: nginx

/etc/nginx/nginx.conf:
  file.managed:
    - source: salt://nginx.conf


/etc/nginx/sites-available/default:
  file.managed:
    - source: salt://nginx-default.conf


/etc/nginx/sites-enabled/default:
  file.symlink:
    - target: /etc/nginx/sites-available/default
    - require:
      - file: /etc/nginx/sites-available/default

