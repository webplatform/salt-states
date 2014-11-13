estheban:
  group.present:
    - gid: 1150
  user.present:
    - fullname: Etienne Lachance <el@elcweb.ca>
    - shell: /bin/bash
    - uid: 1150
    - gid: 10001
    - groups:
      - estheban
      - ops
      - deployment
    - require:
      - group: ops
      - group: deployment

# First key is going to be deprecated
estheban_keys:
  ssh_auth:
    - present
    - user: estheban
    - enc: ssh-rsa
    - require:
      - user: estheban
    - names:
      - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCZT8o/qMJrfv8NSABtQxOay6niB1LdmXck4chgLdVCNciwm74CPBP57VgKdC2+zjzY72ixjI2GqVeTlYdD/yuHOLcfw0oSywEu3c54kYOb/aQ9x4PueE9/0/mtSaHQy4yIWowe/tCrcS6TN3OFaBTquDv28/IgPkiy/DblrbKNxNNMmWXzQikgyApTQ0UmWjsZEFD41pk+Iq879xuXigYpq1I2fao+XCx2ZN6Ri4QOWkl4zTkRN49X5rFxCoiuHe0JUh9q86VRoSDkWISsh0jxehgoQl5d/UPgF4+jP5cA9ke05fIdbFbAg7xGHH03GKnkfHCqg2OJF9HAFI/0OIxp et@etiennelachance.com
