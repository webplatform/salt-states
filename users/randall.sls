include:
  - groups.hypothesis

randall:
  group.present:
    - gid: 1022
  user.present:
    - fullname: Randall Leeds <tilgovi@hypothes.is>
    - shell: /bin/bash
    - uid: 1022
    - gid: 10002
    - groups:
      - randall
      - hypothesis
    - require:
      - group: hypothesis
      - group: randall

randall_keys:
  ssh_auth:
    - present
    - user: randall
    - enc: ssh-rsa
    - require:
      - user: randall
    - names:
      - AAAAB3NzaC1yc2EAAAADAQABAAABAQDF8fiJLNdRkjyqIwhWs/J2OkTFTRVMSk0zVA2RxGYNyJX+HYSzYM+5MGrbzROSfFmIt5mPDMNgChru5/ZQY6XIdTeiiutthx0TIm6vXxOUCj5BC8UYHaMTS1SScLBKLvCsooDpDhDZoUWkDjyew6fB9vJ0NbNyGdYbRmFOUSsNxDJGlZGGantsO0gjOMIsa6EWrEvloarRLuefar3IMVTim/6lb0hUV4cDg3Ou1HEnht2su7zwA6ntZuRXbldtIjIbYhgqbO6nztrqzdknAqeObQE/B5I5npShoDmeKl2pc1O8nAIzUh1z8IndhW6s02ohmkiD2px9kvYQRSoUg6PB tilgovi@vissarion
