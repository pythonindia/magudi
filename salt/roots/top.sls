base:
  '*':
    - base
    - postgresql
    - nginx
  'nodename:in.pycon.org':
    - match: grain
    - blog
    - mail
    - inpycon
    - lib/uwsgi_common
    - junction
  'nodename:pythonexpress.org':
    - match: grain
    - lib/uwsgi_common
    - pythonexpress
    - wye
    - mail
    - lib/celery
