{% set bin_location = '/usr/local/bin/certbot-auto' %}
{% set workspc = '/tmp/certbot' %}

# salt-call --local state.sls le
# set up certbot and config
# certbot-auto certonly -c cli.ini
# finaly generate cert

download_certbot:
  cmd.run:
    - name: curl -L https://dl.eff.org/certbot-auto -o {{bin_location}}
    - creates: {{bin_location}}
  file.managed:
    - name: {{bin_location}}
    - mode: 755
    - require:
      - cmd: download_certbot

{{workspc}}:
  file.directory

{{workspc}}/cli.ini:
  file.managed:
    - source: salt://le/certbot-cli.ini
    - template: jinja
    - require:
      - file: /tmp/certbot
    - defaults:
      workspc: {{ workspc }}

get_cert:
  cmd.run:
    - name: {{bin_location}} certonly -n -c cli.ini
    - cwd: {{workspc}}
    - timeout: 60
    - require:
        - file: {{workspc}}/cli.ini
        - file: download_certbot
