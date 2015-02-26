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

/etc/nginx/nginx.conf:
  file.managed:
    - source: salt://nginx.conf
