/etc/ssl/webplatform/webplatform-201405-class2.pem:
  file.managed:
    - contents: |-
        {{ salt['pillar.get']('certificates:pem:webplatform-201405-class2:contents')|indent(8) }}
