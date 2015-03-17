{% set ssl = pillar['pycon']['ssl'] %}

https://github.com/pythonindia/inpycon2015.git:
  git.latest:
    - rev: master
    - target: /opt/inpycon2015

https://github.com/pythonindia/pyconindia-archive.git:
  git.latest:
    - rev: 7e64c9672cd8efc99f401b1a8bb4fdc38e752912
    - target: /opt/pyconindia-archive

/etc/nginx/sites-available/in.pycon.org.conf:
  file.managed:
    - source: salt://inpycon2015/in.pycon.org.conf
    - template: jinja
    - defaults:
      ssl: {{ ssl }}

/etc/nginx/sites-enabled/in.pycon.org.conf:
  file.symlink:
    - target: /etc/nginx/sites-available/in.pycon.org.conf

/etc/nginx/sites-available/in.pycon.org/:
  file.directory: []

/etc/nginx/sites-available/in.pycon.org/pycon2015.conf:
  file.managed:
    - source: salt://inpycon2015/in.pycon2015.conf

/etc/nginx/sites-available/in.pycon.org/old-pycon.conf:
  file.managed:
    - source: salt://inpycon2015/old-pycon.conf

{% if ssl['on'] %}
/etc/ssl/in.pycon.org.crt:
  file.managed:
    - contents_pillar: pycon:ssl:cert

/etc/ssl/in.pycon.org.key:
  file.managed:
    - contents_pillar: pycon:ssl:key

/etc/ssl/dhparam.pem:
  file.managed:
    - contents_pillar: pycon:ssl:dhkey

/etc/nginx/sites-available/in.pycon.org.with_ssl.conf:
  file.managed:
    - source: salt://inpycon2015/in.pycon.org.with_ssl.conf

{% endif %}
