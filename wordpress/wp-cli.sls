wp-cli-deps:
  pkg.installed:
    - pkgs:
      - php5-cli
      - curl

get-wp-cli:
  cmd.run:
    - name: 'wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar'
    - unless: test -f /usr/local/bin/wp
    - cwd: /root/
    - require:
      - pkg: wp-cli-deps

install-wp-cli:
  cmd.wait:
    - name: mv /root/wp-cli.phar /usr/local/bin/wp;chmod +x /usr/local/bin/wp
    - cwd: /root/
    - watch:
      - cmd: get-wp-cli

