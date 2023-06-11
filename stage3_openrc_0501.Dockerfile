# old (2023.05.01) Gentoo Linux image with openrc 
FROM gentoo/stage3:amd64-openrc-20230501

# Sync Portage source tree
RUN emerge --sync

# Install eselect repository module
RUN emerge --ask app-eselect/eselect-repository dev-vcs/git

# Enable and sync GURU overlay
RUN eselect repository enable guru
RUN emerge --sync guru

# Unmask gentoo_update package
RUN echo 'app-admin/gentoo_update ~amd64' >> /etc/portage/package.accept_keywords/gentoo_update

# Install gentoo_update and dependencies for testing
RUN emerge --quiet-build y app-admin/gentoo_update
RUN emerge --quiet-build y dev-python/pip dev-python/build

