{% set ssl = pillar['pycon']['ssl'] %}

/var/www/html/in.pycon.org/:
  file.directory

https://github.com/pythonindia/inpycon2015.git:
  git.latest:
    - rev: master
    - target: /opt/inpycon2015

https://github.com/pythonindia/inpycon2016.git:
  git.latest:
    - rev: master
    - target: /opt/inpycon2016

https://github.com/pythonindia/inpycon2017.git:
  git.latest:
    - rev: master
    - target: /opt/inpycon2017

https://github.com/pythonindia/pyconindia-archive.git:
  git.latest:
    - rev: 72613218a3ad7123da3804e3df0c19f01c0a684b
    - target: /opt/pyconindia-archive

/etc/nginx/sites-available/in.pycon.org.conf:
  file.managed:
    - source: salt://inpycon/in.pycon.org.conf
    - template: jinja
    - makedirs: True
    - defaults:
      ssl: {{ ssl }}

/etc/nginx/sites-enabled/in.pycon.org.conf:
  file.symlink:
    - target: /etc/nginx/sites-available/in.pycon.org.conf
    - require:
        - file: /etc/nginx/sites-available/in.pycon.org.conf
        - file: nginx_config_folders

nginx_inpycon_dir:
  file.directory:
    - names:
        - /etc/nginx/sites-available/in.pycon.org/
    - require:
        - file: nginx_config_folders

/etc/nginx/sites-available/in.pycon.org/pycon2015.conf:
  file.managed:
    - source: salt://inpycon/in.pycon2015.conf
    - require:
        - file: nginx_inpycon_dir

/etc/nginx/sites-available/in.pycon.org/pycon2016.conf:
  file.managed:
    - source: salt://inpycon/in.pycon2016.conf
    - require:
        - file: nginx_inpycon_dir

/etc/nginx/sites-available/in.pycon.org/old-pycon.conf:
  file.managed:
    - source: salt://inpycon/old-pycon.conf
    - require:
        - file: nginx_inpycon_dir

{% if ssl['on'] %}
/etc/ssl/in.pycon.org.2016.fullchain.pem:
  file.managed:
    - contents_pillar: pycon:ssl:cert

/etc/ssl/in.pycon.org.2016.pvtkey.pem:
  file.managed:
    - contents_pillar: pycon:ssl:key

/etc/ssl/dhparam.pem:
  file.managed:
    - contents_pillar: pycon:ssl:dhkey

/etc/nginx/sites-available/in.pycon.org.with_ssl.conf:
  file.managed:
    - source: salt://inpycon/in.pycon.org.with_ssl.conf

{% endif %}
