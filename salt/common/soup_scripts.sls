# Sync some Utilities
soup_scripts:
  file.recurse:
    - name: /usr/sbin
    - user: root
    - group: root
    - file_mode: 755
    - source: salt://common/tools/sbin
    - include_pat:
        - so-common
        - so-image-common

soup_manager_scripts:
  file.recurse:
    - name: /usr/sbin
    - user: root
    - group: root
    - file_mode: 755
    - source: salt://manager/tools/sbin
    - include_pat:
        - so-firewall
        - soup

soup_manager_reposync:
  file.recurse:
    - name: /usr/sbin
    - user: root
    - group: root
    - file_mode: 755
    - source: salt://manager/tools/sbin_jinja
    - template: jinja
    - include_pat:
        - so-repo-sync