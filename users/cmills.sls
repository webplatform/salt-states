cmills:
  group.present:
    - gid: 1013
  user.present:
    - shell: /bin/bash
    - uid: 1013
    - gid: 10001
    - groups:
      - ops
      - cmills
    - require:
      - group: cmills
      - group: ops
      - group: deployment

AAAAB3NzaC1kc3MAAACBAMAqHbw8NXwXAAZAdKauO0Fg1YTdSacXTzuU/g70CS8qUsergBNfND91q38IyZ15allWX29hoiBg4YyGVu0Qi03+3UTnWezbobwV0UMwwph0c1lfdTpGoN0WMiKjku6+/K0k95bsNXY0xj/xmQtRMitz8RiMo/p7OJBXEErVdmxRAAAAFQCFpvXQDCsGDYOZG7YiSSp4wiN61QAAAIAHOme4/zHwW+zwe+5+abIIwsPyghjNw2tzCIPW956bjBfI9e25TIaKnKy5RdKHXCIF9KL4cmD+eaneAdScm5yTqXVHJM1BY7lh70RQpfYFLfuyWh0HJ+NuZ3ir+UbTH05zf+AQHpJS5qlRFn/3ecTZXE4HpFVJDVdaHqyLJmMb+wAAAIAfe2DabreqlZr0cZDKh37WeJ5dSwFhtSEZYCrLnin/DcYP/7hq9EqSLZr/ZUcoWskWHI4CuD+jwiAcIpdHH03GcfbZeqXyWGCIpIE34sW6Ev2WdEKpUH1FPFWjIqdsj8wmybzlJg90tSm5UTDQwr2aXa9yW0qZaL1sfBCBdfjZKA==:
  ssh_auth:
    - present
    - user: cmills
    - enc: ssh-dss
    - comment: chrismills@chris-windows.lan
    - require:
      - user: cmills
