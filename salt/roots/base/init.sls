base_installs:
  pkg.installed:
    - names:
      - git
      - htop
      - curl
      - zsh
      - vim-nox

include:
  - base/ntp
