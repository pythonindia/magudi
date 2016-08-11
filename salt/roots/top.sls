base:
  '*':
    - base
    - postgresql
    - nginx
  'id:in.pycon.org':
    - match: grain
    - blog
    - mail
    - inpycon
    - lib/uwsgi_common
    - junction
  'nodename:pythonexpress':
    - match: grain
    - lib/uwsgi_common
    - pythonexpressin
    - wye
    - mail
    - lib/celery
