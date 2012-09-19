yaron:
  group.present:
    - gid: 1003
  user.present:
    - shell: /bin/bash
    - uid: 1003
    - gid: 10001
    - groups:
      - ops
      - yaron
    - require:
      - group: yaron
      - group: ops
      - group: deployment

yaron_keys:
  ssh_auth:
    - present
    - user: yaron
    - enc: ssh-dss
    - require:
      - user: yaron
    - names:
      - AAAAB3NzaC1kc3MAAACBANKwx1cjjw732LqBBokF3eQQ5jUaMWKPw0j8wQdY3FeoFekQweTV9QKWlpncJXoS5Z9tAFYxC4vCNtJ5kx00WJIlGZtXNdRcNwYZ7eWLPcOydXzAVJI98YxYH4sHf51m4Aegs2Vi23fYnuyfasSXWPoZYBk5l3XyKruaKYDjzEg3AAAAFQD4iNRsG3OGs79mDwcNlJkjKtfHfQAAAIBsmsIa3EOgKIqIFyrysBJFbAx2zcG24v5vv137WncpKHC9FLxclai+/lMxLWllLgVQilddqr7ZGJh6HompHyfSDx+neCIbEll/jhaNmyB023Ujy/CbtX6Wx1Eru0nOSLbJAE38XmyA2jjoMVK3cZxgpQsQNqftQmPK5tobU13NlQAAAIBNkQA1QGhD2JPcd62UlALy4/Qb1yikz1EuuDrI6TXmaZ81ixW4WM8oG0uKrjCjyrAV2uKgDzRvsV8AqYBD6Er79O6XbQL5fFam+OGqiliEVml+2lGEJqNMwORlJhQvjCa61Z5puR2SeEm7QQbv+O/UU6eF/COEyEhTznjAuZIofA== ngrandy@server.discoursedb.org
