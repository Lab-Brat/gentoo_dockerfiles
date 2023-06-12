# Gentoo Linux image with systemd
FROM gentoo/stage3:systemd

# Sync Portage source tree
RUN emerge --sync

# Install eselect repository module
RUN emerge app-eselect/eselect-repository dev-vcs/git

# Enable and sync GURU overlay
RUN eselect repository enable guru
RUN emerge --sync guru

# Unmask gentoo_update package
RUN echo 'app-admin/gentoo_update ~amd64' >> /etc/portage/package.accept_keywords/gentoo_update

# Install gentoo_update and dependencies for testing
RUN emerge --quiet-build y app-admin/gentoo_update
RUN emerge --quiet-build y dev-python/pip dev-python/build

