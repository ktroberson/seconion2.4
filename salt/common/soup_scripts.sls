{% set CURRENT_VERSION = salt['pillar.get']('global:soversion') %}
{% if salt['file.directory_exists']('/tmp/soagupdate/SecurityOnion') or salt['file.directory_exists']('/tmp/sogh/securityonion') %}

update_common_scripts:
  file.recurse:
    - name: /usr/sbin
    - user: root
    - group: root
    - file_mode: 755
{%  if salt['file.directory_exists']('/tmp/soagupdate/SecurityOnion') %}
    - source: /tmp/soagupdate/SecurityOnion/salt/common/tools/sbin/
{%  else salt['file.directory_exists']('/tmp/sogh/securityonion') %}
    - source: /tmp/sogh/securityonion/salt/common/tools/sbin/
{%  endif %}
    - include_pat:
        - so-common
        - so-image-common
update_manager_scripts:
  file.recurse:
    - name: /usr/sbin
    - user: root
    - group: root
    - file_mode: 755
{%  if salt['file.directory_exists']('/tmp/soagupdate/SecurityOnion') %}
    - source: /tmp/soagupdate/SecurityOnion/salt/manager/tools/sbin/
{%  else salt['file.directory_exists']('/tmp/sogh/securityonion') %}
    - source: /tmo/sogh/securityonion/salt/manager/tools/sbin/
{%  endif %}
    - include_pat:
        - so-firewall
        - so-repo-sync
        - soup

{% endif %}