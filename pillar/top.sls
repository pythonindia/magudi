base:
  '*':
    - junction
    - pycon
    - wye
    - pythonexpress
  'nodename:in.pycon.org':
    - match: grain
    - pycon_mail
  'nodename:pythonexpress.in':
    - match: grain
    - pythonexpress_mail
