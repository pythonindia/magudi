base:
  '*':
    - base
    - postgresql
    - nginx
    - pythonexpressin
  'nodename:in.pycon.org':
    - match: grain
    - blog
    - mail
    - inpycon2015
    - lib/uwsgi_common
    - junction
  'nodename:pythonexpress.in':
    - match: grain
    - lib/uwsgi_common
    - wye
