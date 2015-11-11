{% set db = pillar['junction']['db'] %}
{% set qr_codes_dir = pillar['junction']['qr_codes_dir'] %}

{{ qr_codes_dir }}:
  file.directory:
    - user: app
    - dir_mode: 755
    - require:
      - file: /opt/junction
      - git: junction_code

junction_code:
  git.latest:
    - name: https://github.com/pythonindia/junction.git
    - rev: {{ pillar['junction']['revs']['junction']}}
    - target: /opt/junction
    - user: app
    - require:
      - file: /opt/junction

/opt/envs/junction:
  virtualenv.managed:
    - system_site_packages: False
    - require:
      - git: junction_code
      - pkg: virtualenv
      - file: /opt/envs
    - user: app

junction_pip_upgrade:
  pip.installed:
    - name: pip
    - upgrade: True
    - bin_env: /opt/envs/junction
    - require:
      - virtualenv: /opt/envs/junction
      - file: /opt/junction/settings/prod.py
    - user: app

junction_pip_requirements:
  pip.installed:
    - requirements: /opt/junction/requirements.txt
    - bin_env: /opt/envs/junction
    - require:
      - pip: junction_pip_upgrade
    - user: app


/opt/envs/junction/bin/python manage.py migrate:
  cmd.run:
    - cwd: /opt/junction
    - require:
      - pip: junction_pip_requirements
      - file: /opt/junction/settings/prod.py
      - postgres_database: junction_database
    - user: app

/opt/junction/settings/prod.py:
  file.managed:
    - user: app
    - source: salt://junction/files/settings.py.j2
    - template: jinja
    - defaults:
      email_host_password: {{ pillar['junction']['email_host_password'] }}
      db: {{ db }}
      admins: {{ pillar['junction']['admins']}}
    - user: app

/opt/envs/junction/bin/python manage.py collectstatic --noinput:
  cmd.run:
    - cwd: /opt/junction
    - require:
      - virtualenv: /opt/envs/junction
      - file: /opt/junction/settings/prod.py
    - user: app
