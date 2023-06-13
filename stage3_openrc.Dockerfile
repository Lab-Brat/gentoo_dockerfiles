# Gentoo Linux image with openrc
FROM gentoo/stage3:amd64-desktop-openrc-20230501

# Sync Portage source tree
RUN emerge --sync

# Install eselect repository module
RUN emerge --quiet-build app-eselect/eselect-repository dev-vcs/git

# Enable and sync GURU overlay
RUN eselect repository enable guru
RUN emerge --sync guru

# Install dependencies for testing
RUN emerge --quiet-build y dev-python/pip dev-python/build

