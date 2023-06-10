# Gentoo Linux image with systemd
FROM gentoo/stage3:systemd

# Sync Portage source tree
RUN emerge --sync

# Install eselect repository module
RUN emerge --ask app-eselect/eselect-repository dev-vcs/git

# Enable and sync GURU overlay
RUN eselect repository enable guru
RUN emerge --sync guru

# Install gentoo_update and dependencies for testing
RUN emerge --quiet-build y app-admin/gentoo_update
RUN emerge --quiet-build y dev-python/pip dev-python/build

