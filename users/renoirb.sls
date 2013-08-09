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
    - comment: hello@renoirboulanger.com
    - require:
      - user: renoirb

AAAAB3NzaC1yc2EAAAADAQABAAABAQDlrp/7uNPxICppMUD6BSpQm8Xzjo4EUJHqZL7k5nEdNe0GqSOOw5W1UxAtuBx69PukWAfOtrbXgsaTha7gZSX7lLi34UF+Lp/b/mz2FXOl/d4cVNDjfaBeSptV5rDoohyuR15WqrussA3UPqris5jsuyUgK/+xnQHvbgSvQ3yWU9Rfy4lnlGpznPs1G3uF9JY1LZLb56brOOfPPSNtO/mYjaxvniqWZI6oTtEMM9XM8tDaZNWA3s08riBslj0EWSzcGOBhQ0oHMVGElgwWNvSYRVyb1xjW9raaFtKdfsK2nKTGUJ6wIx1+V4jSOJWpmq9+y7jJmNHDijpAPTO4NvZz:
  ssh_auth:
    - present
    - user: renoirb
    - enc: ssh-rsa
    - require:
      - user: renoirb
