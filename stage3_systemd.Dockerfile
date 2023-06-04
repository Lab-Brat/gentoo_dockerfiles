# Gentoo Linux image with systemd
FROM gentoo/stage3:systemd

# Sync Portage source tree
RUN emerge --sync

# Install gentoo_update ependencies
RUN emerge --quiet-build y app-portage/gentoolkit app-admin/needrestart

# Install testing dependencies
RUN emerge --quiet-build y dev-python/pip dev-python/build

