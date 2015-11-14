{% set db = pillar['junction']['db'] %}

{% from "lib/db.sls" import database %}
{% from "lib/uwsgi.sls" import uwsgi %}
{% from "lib/code.sls" import code %}
{% from "lib/env_update.sls" import env_update %}

{% set name = 'junction' %}

{{ database(name, db) }}
{{ uwsgi(name, pillar[name]['server_config']) }}
{{ code(name, pillar[name]['revs'][name], 'requirements.txt')}}
{{ env_update(name)}}

{% set qr_codes_dir = pillar['junction']['qr_codes_dir'] %}

{{ qr_codes_dir }}:
  file.directory:
    - user: app
    - dir_mode: 755
    - require:
      - file: /opt/junction
      - git: junction_code

/opt/junction/settings/prod.py:
  file.managed:
    - user: app
    - source: salt://junction/files/settings.py.j2
    - template: jinja
    - defaults:
      email_host_password: {{ pillar[name]['email_host_password'] }}
      db: {{ db }}
      admins: {{ pillar[name]['admins']}}

include:
  - junction/service
