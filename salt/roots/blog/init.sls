/opt/inpycon_blog/:
  file.directory:
    - user: app
    - group: app

blog_repo:
  git.latest:
    - name: https://github.com/pythonindia/inpycon-blog.git
    - rev: master
    - target: /opt/inpycon_blog/
    - user: app
    - require:
      - file: /opt/inpycon_blog/

/opt/envs/inpycon_blog:
  virtualenv.managed:
    - system_site_packages: False
    - requirements: /opt/inpycon_blog/requirements.txt
    - require:
      - git: blog_repo
      - pkg: virtualenv
      - file: /opt/envs
    - user: app

publish_blog:
  cmd.run:
    - name: export PATH="/opt/envs/inpycon_blog/bin:$PATH" && make publish
    - cwd: /opt/inpycon_blog/
    - require:
      - virtualenv: /opt/envs/inpycon_blog
    - user: app

/etc/nginx/sites-available/in.pycon.org/blog.conf:
  file.managed:
    - source: salt://blog/blog.conf.j2
