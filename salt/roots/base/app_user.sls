app_group:
  group.present:
    - name: app


app:
  user.present:
    - fullname: App
    - shell: /bin/bash
    - home: /home/app
    - empty_password: True
    - groups:
      - app
    - require:
      - group: app_group
