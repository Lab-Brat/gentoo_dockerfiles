# Gentoo Linux image with openrc
FROM gentoo/stage3:amd64-desktop-openrc-20230501

# Sync Portage source tree
RUN emerge --sync

# Install gentoo_update ependencies
RUN emerge --quiet-build y app-portage/gentoolkit app-admin/needrestart

# Install testing dependencies
RUN emerge --quiet-build y dev-python/pip dev-python/build

