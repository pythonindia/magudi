base:
  '*':
    - base
    - postgresql
    - nginx
    - pythonexpressin
  'in.pycon.org':
    - blog
    - mail
    - inpycon2015
    - lib/uwsgi_common
    - junction
  'pythonexpress.in':
    - lib/uwsgi_common
    - wye
