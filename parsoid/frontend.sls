{%- set tld = salt['pillar.get']('infra:current:tld', 'webplatform.org') -%}
{%- set upstream_port = salt['pillar.get']('upstream:parsoid:port', 8007) -%}
{%- set upstreams = salt['pillar.get']('upstream:parsoid:nodes', ['127.0.0.1']) %}

include:
  - nginx

{% from "nginx/macros.sls" import frontend_vhost %}
{{ frontend_vhost('parsoid', upstream_port, upstreams, tld) }}
