jkomoros:
  group.present:
    - gid: 1006
  user.present:
    - shell: /bin/bash
    - uid: 1006
    - gid: 10001
    - groups:
      - ops
      - jkomoros
    - require:
      - group: jkomoros
      - group: ops
      - group: deployment

AAAAB3NzaC1yc2EAAAADAQABAAABAQDELmF8jVQtOWDtPApiJAS2dblug17oqP4GCG0FDtIz1CuvCz6gC7GQRUzbm4KLydex/OWJiVzk5AksawfdpTzrTfyVHAhaRLlADUXNYbpUx86ggY8cfWHiTpeZvO93vnHoE2a9fG1jYP7Hh+P85XurYdS4jpX6bA2gUs29LwVxwnfhqr4JLpWdCFn1dgAZsJ01IdRJkaFDjSTzA6x8AdMZ9K/cIq6NvbfU/+9Im7vC61XkwSFTcM0Dr9ZLGJE2XtMjMuAvFsUaA+UC0Zg4Mk+wWg5BtKItC8hFna15p0Dtw1fS3QoJq2fbO+uDE1StYU+bDsXdkZCfcbmbwQhQHeyf:
  ssh_auth:
    - present
    - user: jkomoros
    - enc: ssh-rsa
    - comment: jkomoros@gmail.com
    - require:
      - user: jkomoros
