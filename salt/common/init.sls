# Add socore Group
socoregroup:
  group.present:
    - name: socore
    - gid: 939

# Add socore user
socore:
  user.present:
    - uid: 939
    - gid: 939
    - home: /opt/so
    - createhome: True
    - shell: /bin/bash

# Create a state directory

statedir:
  file.directory:
    - name: /opt/so/state
    - user: 939
    - group: 939
    - makedirs: True

salttmp:
  file.directory:
    - name: /opt/so/tmp
    - user: 939
    - group: 939
    - makedirs: True

# Install packages needed for the sensor

sensorpkgs:
  pkg.installed:
    - skip_suggestions: False
    - pkgs:
      - docker-ce
      {% if grains['os'] != 'CentOS' %}
      - python-docker
      - python-m2crypto
      {% endif %}

# Always keep these packages up to date

alwaysupdated:
  pkg.latest:
    - pkgs:
      - openssl
      - openssh-server
      - bash
    - skip_suggestions: True

# Set time to UTC

Etc/UTC:
  timezone.system

# Make sure Docker is running!
docker:
  service.running:
    - enable: True

# Drop the correct nginx config based on role

nginxconfdir:
  file.directory:
    - name: /opt/so/conf/nginx
    - user: 939
    - group: 939
    - makedirs: True

nginxconf:
  file.managed:
    - name: /opt/so/conf/nginx/nginx.conf
    - user: 939
    - group: 939
    - template: jinja
    - source: salt://common/nginx/nginx.conf.{{ grains.role }}

nginxlogdir:
  file.directory:
    - name: /opt/so/log/nginx/
    - user: 939
    - group: 939
    - makedirs: True

nginxtmp:
  file.directory:
    - name: /opt/so/tmp/nginx/tmp
    - user: 939
    - group: 939
    - makedirs: True

# Start the core docker
so-core:
  docker_container.running:
    - image: soshybridhunter/so-core:HH1.0.3
    - hostname: so-core
    - user: socore
    - binds:
      - /opt/so:/opt/so:rw
      - /opt/so/conf/nginx/nginx.conf:/etc/nginx/nginx.conf:ro
      - /opt/so/log/nginx/:/var/log/nginx:rw
      - /opt/so/tmp/nginx/:/var/lib/nginx:rw
      - /opt/so/tmp/nginx/:/run:rw
      - /etc/pki/masterssl.crt:/etc/pki/nginx/server.crt:ro
      - /etc/pki/masterssl.key:/etc/pki/nginx/server.key:ro
    - cap_add: NET_BIND_SERVICE
    - port_bindings:
      - 80:80
      - 443:443
    - watch:
      - file: /opt/so/conf/nginx/nginx.conf

# Add Telegraf to monitor all the things.
tgraflogdir:
  file.directory:
    - name: /opt/so/log/telegraf
    - makedirs: True

tgrafetcdir:
  file.directory:
    - name: /opt/so/conf/telegraf/etc
    - makedirs: True

tgrafetsdir:
  file.directory:
    - name: /opt/so/conf/telegraf/scripts
    - makedirs: True

tgrafsyncscripts:
  file.recurse:
    - name: /opt/so/conf/telegraf/scripts
    - user: 939
    - group: 939
    - file_mode: 755
    - template: jinja
    - source: salt://common/telegraf/scripts

tgrafconf:
  file.managed:
    - name: /opt/so/conf/telegraf/etc/telegraf.conf
    - user: 939
    - group: 939
    - template: jinja
    - source: salt://common/telegraf/etc/telegraf.conf

so-telegraf:
  docker_container.running:
    - image: soshybridhunter/so-telegraf:HH1.0.4
    - environment:
      - HOST_PROC=/host/proc
      - HOST_ETC=/host/etc
      - HOST_SYS=/host/sys
      - HOST_MOUNT_PREFIX=/host
    - network_mode: host
    - binds:
      - /opt/so/log/telegraf:/var/log/telegraf:rw
      - /opt/so/conf/telegraf/etc/telegraf.conf:/etc/telegraf/telegraf.conf:ro
      - /var/run/utmp:/var/run/utmp:ro
      - /var/run/docker.sock:/var/run/docker.sock:ro
      - /:/host/root:ro
      - /sys:/host/sys:ro
      - /proc:/host/proc:ro
      - /nsm:/host/nsm:ro
      - /etc:/host/etc:ro
      {% if grains['role'] == 'so-master' or grains['role'] == 'so-eval' %}
      - /etc/pki/ca.crt:/etc/telegraf/ca.crt:ro
      {% else %}
      - /etc/ssl/certs/intca.crt:/etc/telegraf/ca.crt:ro
      {% endif %}
      - /etc/pki/influxdb.crt:/etc/telegraf/telegraf.crt:ro
      - /etc/pki/influxdb.key:/etc/telegraf/telegraf.key:ro
      - /opt/so/conf/telegraf/scripts:/scripts:ro
      - /opt/so/log/stenographer:/var/log/stenographer:ro
    - watch:
      - /opt/so/conf/telegraf/etc/telegraf.conf
      - /opt/so/conf/telegraf/scripts

# If its a master or eval lets install the back end for now
{% if grains['role'] == 'so-master' or grains['role'] == 'so-eval' %}

# Influx DB
influxconfdir:
  file.directory:
    - name: /opt/so/conf/influxdb/etc
    - makedirs: True

influxdbdir:
  file.directory:
    - name: /nsm/influxdb
    - makedirs: True

influxdbconf:
  file.managed:
    - name: /opt/so/conf/influxdb/etc/influxdb.conf
    - user: 939
    - group: 939
    - template: jinja
    - source: salt://common/influxdb/etc/influxdb.conf

so-influxdb:
  docker_container.running:
    - image: soshybridhunter/so-influxdb:HH1.0.4
    - hostname: influxdb
    - environment:
      - INFLUXDB_HTTP_LOG_ENABLED=false
    - binds:
      - /opt/so/conf/influxdb/etc/influxdb.conf:/etc/influxdb/influxdb.conf:ro
      - /nsm/influxdb:/var/lib/influxdb:rw
      - /etc/pki/influxdb.crt:/etc/ssl/influxdb.crt:ro
      - /etc/pki/influxdb.key:/etc/ssl/influxdb.key:ro
    - port_bindings:
      - 0.0.0.0:8086:8086

# Grafana all the things
grafanadir:
  file.directory:
    - name: /nsm/grafana
    - user: 939
    - group: 939
    - makedirs: True

grafanaconfdir:
  file.directory:
    - name: /opt/so/conf/grafana/etc
    - user: 939
    - group: 939
    - makedirs: True

grafanadashdir:
  file.directory:
    - name: /opt/so/conf/grafana/grafana_dashboards
    - user: 939
    - group: 939
    - makedirs: True

grafanaconf:
  file.recurse:
    - name: /opt/so/conf/grafana/etc
    - user: 939
    - group: 939
    - template: jinja
    - source: salt://common/grafana/etc

{% if salt['pillar.get']('sensorstab', False) %}
{%- for SN, SNDATA in salt['pillar.get']('sensorstab', {}).iteritems() %}
dashboard-{{ SN }}:
  file.managed:
    - name: /opt/so/conf/grafana/grafana_dashboards/{{ SN }}-Sensor.json
    - user: 939
    - group: 939
    - template: jinja
    - source: salt://common/grafana/grafana_dashboards/sensor.json
    - defaults:
      SERVERNAME: {{ SN }}
      MONINT: {{ SNDATA.monint }}
      MANINT: {{ SNDATA.manint }}

{% endfor %}
{% endif %}


# Install the docker. This needs to be behind nginx at some point
so-grafana:
  docker_container.running:
    - image: soshybridhunter/so-grafana:HH1.0.4
    - hostname: grafana
    - user: socore
    - binds:
      - /nsm/grafana:/var/lib/grafana:rw
      - /opt/so/conf/grafana/etc/datasources:/etc/grafana/provisioning/datasources:rw
      - /opt/so/conf/grafana/etc/dashboards:/etc/grafana/provisioning/dashboards:rw
      - /opt/so/conf/grafana/grafana_dashboards:/etc/grafana/grafana_dashboards:rw
    - environment:
      - GF_SECURITY_ADMIN_PASSWORD=augusta
    - port_bindings:
      - 0.0.0.0:3000:3000
    - watch:
      - file: /opt/so/conf/grafana/etc/*
      
{% endif %}
