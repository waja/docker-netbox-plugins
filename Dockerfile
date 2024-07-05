# checkov:skip=CKV_DOCKER_2: no healthcheck (yet)
# checkov:skip=CKV_DOCKER_3: we don't want to drift away from upstream. so we keep it as it is
# checkov:skip=CKV_DOCKER_7: yes, latest is okay here
# hadolint ignore=DL3007
FROM netboxcommunity/netbox:latest

# Define required plugins
RUN echo 'netbox-secrets' >> /opt/netbox/plugin_requirements.txt && \
  # Install plugins
 /opt/netbox/venv/bin/pip install  --no-warn-script-location -r /opt/netbox/plugin_requirements.txt && \
 # Install static files from our plugins
 SECRET_KEY="dummydummydummydummydummydummydummydummydummydummy" /opt/netbox/venv/bin/python /opt/netbox/netbox/manage.py collectstatic --no-input && \
 # Activate plugins
 echo 'PLUGINS = ["netbox_secrets"]' >> /etc/netbox/config/configuration.py