wye:
  server_config:
    port: 8903
    module: wye.wsgi:application
  db:
    user: wye
    password: wye
    name: wye
  email_host_password: dummy
  admins:
    Test Me: test@sample.fake # add your email for testing.
  revs:
    wye: master
  host: pycon.local.org:8000
  google_analytics_id: UA-XXXXXXX-1
