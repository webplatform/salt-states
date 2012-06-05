/etc/apache2/mods-enabled/ssl.conf:
  file.symlink:
    - target: /etc/apache2/mods-available/ssl.conf

/etc/apache2/mods-enabled/ssl.load:
  file.symlink:
    - target: /etc/apache2/mods-available/ssl.load
