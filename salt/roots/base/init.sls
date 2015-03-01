base_installs:
  pkg.installed:
    - names:
      - git
      - htop
      - curl
      - zsh
      - vim-nox

Asia/Kolkata:
  timezone.system

include:
  - base/ntp
  # - base/admin_user
  - base/app_user
  - base/python
