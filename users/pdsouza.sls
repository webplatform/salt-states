pdsouza:
  group.present:
    - gid: 1018
  user.present:
    - fullname: Patrick DSouza <pdsouza@about.com>
    - uid: 1018
    - gid: 10001
    - groups:
      - pdsouza
      - ops
      - deployment

pdsouza_keys:
  ssh_auth:
    - present
    - user: pdsouza
    - enc: ssh-dss
    - require:
      - user: pdsouza
    - names:
      - AAAAB3NzaC1kc3MAAACBAN2N/pwQ/04U+j0XGvzxM6Sn/iOOmakwptSWl7sioCh0JX/g0jUACciKv89ne7NNKe4iGk3kfMM5O2o/FrxhAfs6GFzsUiQfyqQIwe9nPxZGa5JNU+Y8cYk6AtCtH7f7WlQnouzikE4t7oM3yn2XQ6qxR2ZabaRfldm1qv6T2/I5AAAAFQDi4SuJEijRgmAzUCeW5LpjPayBzQAAAIEAnGE2BbCHzjqw26Rrjq1NZQ4Lj/r+j0Sp40wYfFGRCZJR5b72oWY/xO6gYx7yCGn86IuE3xl6szUjxzXTPXv4Pnn9aSEPcvgCelrw+6uJq+hll8tpSjjR/VftMQDA1CGC1Xe1/lUlxvSvD46ZvTyoIhsimHQXVOpNLFbZmX/+T5AAAACAY5Xt4yh0JV/f1kHs1efBlT+n3D7F0WXR8PcDRxuTHxlHypZGYGsN9yW2woKZItnKAScoyomL4+1oxzjk6cOaOCTVKDJFyV4Zp4GRQfsSVx/VOMLfaq3frUBrEWixGOVIqUFNpjlOCNhwsnzgww4R6s/LdlSCuEslZMz7JxIX/EI= wpd@patrick-ubuntu

