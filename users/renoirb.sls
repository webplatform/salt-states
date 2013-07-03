renoirb:
  group.present:
    - gid: 1017
  user.present:
    - shell: /bin/bash
    - uid: 1017
    - gid: 10001
    - groups:
      - ops
      - renoirb
    - require:
      - group: renoirb
      - group: ops
      - group: deployment

AAAAB3NzaC1yc2EAAAADAQABAAABAQDE5T7FUwRhRt7Wl/99V52OzFjD9VeK3cZwwiVpHpru+mWjtP4bIixV0ME6xjFG2ro0BhpyckgeWraJQIEoeUeI2UVAUP6+V180tsqRU96POuvsJsBVFkWFcReV/bT25hBuyxhyhHMu7KvvSXWY5lTvQcSmLtd+NgEz9OI69ezTxaLjjznzxh75kgTPttDUB3J/Rf4fznCn7NO4Q+DYbjwBhIbZElpc6eNb7Hlx5Q+9sEiL/BLqFkGLax3Xsi3+USpbWeFASqrmTrXAYwlHpGhK95tLE6dIMCHDtE8x0xqU0xpD/G3JS0DbsrTK75DoA4VE9C6l3NgJDfj6xrsVZrRX:
  ssh_auth:
    - absent
    - user: renoirb
    - enc: ssh-rsa
    - comment: 3935392
    - require:
      - user: renoirb

AAAAB3NzaC1yc2EAAAADAQABAAABAQC3yWFgjwICPb8kQdkO8OX228tGnRLzCvEV74QccCIGwZ3KvXzN9RDRdUZ7fr5sGhwx5s7WQbXkLwOtAxyAUPB1K2DJnJiK/99n4lEjR3vUZN5p7ni7LsrwuoD0A7fF3PlBILYI294xaI/nikJFP14MKgX2TZcEBfY6bVeNmIuthlimKsfpIA2KtKm56zurMjVfjPCQYmcrThs0Wa4ArlAal8IlwPcLAJrjWaFfqjJlIA+PwclXj1xbRLhALkwNmFwkTsea1oT70ydFAeWH+Ui8+bTpjtEIthDVL1BkQ8mMhbrRXa/rVFU72ENc7iY2pknKSBA0hlRRumG8gYKAAhh1:
  ssh_auth:
    - present
    - user: renoirb
    - enc: ssh-rsa
    - comment: ecrire@renoirboulanger.com
    - require:
      - user: renoirb
