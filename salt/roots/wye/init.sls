{% set db = pillar['wye']['db'] %}

{% from "lib/db.sls" import database %}
{% from "lib/uwsgi.sls" import uwsgi %}
{% from "lib/code.sls" import code %}
{% from "lib/env_update.sls" import env_update %}

{% set name = 'wye' %}

{{ database(name, db) }}
{{ uwsgi(name, pillar[name]['server_config']) }}
{{ code(name, pillar[name]['revs'][name], 'requirements/base.txt')}}
{{ env_update(name)}}

/opt/wye/settings/prod.py:
  file.managed:
    - user: app
    - source: salt://wye/files/prod.py.j2
    - template: jinja
    - defaults:
      db: {{ db }}
      admins: {{ pillar[name]['admins']}}

include:
  - wye/service
