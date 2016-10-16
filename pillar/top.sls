base:
  '*':
    - pycon
    - pythonexpress
  'nodename:in.pycon.org':
    - match: grain
    - junction
    - pycon_mail
  'nodename:pythonexpress.in':
    - match: grain
    - wye
    - pythonexpress_mail
