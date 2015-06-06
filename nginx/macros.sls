{% macro frontend_vhost(name, upstream_port, upstreams, tld) %}
/etc/nginx/sites-available/{{ name }}:
  file.managed:
    - source: salt://{{ name }}/files/nginx.frontend.conf.jinja
    - template: jinja
    - context:
        tld: {{ tld }}
        upstream_port: {{ upstream_port }}
        upstreams: {{ upstreams }}
    - require:
      - pkg: nginx

/etc/nginx/sites-enabled/10-{{ name }}:
  file.symlink:
    - target: /etc/nginx/sites-available/{{ name }}
    - require:
      - file: /etc/nginx/sites-available/{{ name }}
{% endmacro %}
