{% set ssl = pillar['pycon']['ssl'] %}

https://github.com/pythonindia/inpycon2015.git:
  git.latest:
    - rev: master
    - target: /opt/inpycon2015

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
/etc/nginx/sites-available/in.pycon.org.with_ssl.conf:
  file.managed:
    - source: salt://inpycon2015/in.pycon.org.with_ssl.conf

/etc/ssl/in.pycon.org.crt:
  file.managed:
    - content: |
        {{ ssl['cert'] | indent(8) }}

/etc/ssl/in.pycon.org.key:
  file.managed:
    - content: |
        {{ ssl['key'] | indent(8) }}
{% endif %}
