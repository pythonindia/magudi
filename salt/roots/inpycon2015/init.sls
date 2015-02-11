https://github.com/pythonindia/inpycon2015.git:
  git.latest:
    - rev: master
    - target: /opt/inpycon2015

/etc/nginx/sites-available/in.pycon.org.conf:
  file.managed:
    - source: salt://inpycon2015/in.pycon.org.conf

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
