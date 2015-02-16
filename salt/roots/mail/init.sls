mail-pkgs:
  pkg.installed:
    - pkgs:
      - exim4
      - exim4-daemon-heavy
      - dovecot-imapd
      - spamc
      - sa-exim
      - swaks

/etc/mailname:
  file.managed:
    - mode: 644
    - contents: in.pycon.org

############
# exim4

/etc/exim4/update-exim4.conf.conf:
  file.managed:
    - source: salt://mail/exim4/update-exim4.conf.conf

/etc/exim4/virtual:
  file.recurse:
    - source: salt://mail/exim4/virtual

/etc/exim4/virtual/pycon.pssi.org.in:
  file.managed:
    - source: salt://mail/exim4/virtual/in.pycon.org
    - require:
      - file: /etc/exim4/virtual

/etc/exim4/conf.d/:
  file.recurse:
    - source: salt://mail/exim4/conf.d/
    - require:
      - pkg: mail-pkgs

clamav:
  user.present:
    - optional_groups:
      - Debian-exim
    - require:
      - pkg: mail-pkgs

/var/run/clamav:
  file.directory:
    - group: Debian-exim
    - require:
      - pkg: mail-pkgs

update-exim4.conf:
  cmd.run:
    - require:
      - file: /etc/exim4/virtual
      - file: /etc/exim4/update-exim4.conf.conf

exim4:
  service.running:
    - require:
      - cmd: update-exim4.conf
