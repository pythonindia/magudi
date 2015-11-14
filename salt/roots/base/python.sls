virtualenv:
  pkg.installed:
    - names:
        - python-dev
        - python-virtualenv
        - python-pip

        # Pillow dependancies, generally required.
        - libtiff5-dev
        - libjpeg8-dev
        - zlib1g-dev
        - libfreetype6-dev
        - liblcms2-dev
        - libwebp-dev
        - tcl8.6-dev
        - tk8.6-dev
        - python-tk
