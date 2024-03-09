# old (2024.02.05) Gentoo Linux image with openrc 
FROM gentoo/stage3:amd64-openrc-20240205

ENV FEATURES="-ipc-sandbox -mount-sandbox -network-sandbox -pid-sandbox"

# Sync Portage source tree
RUN emerge --sync

# Install eselect repository module
RUN emerge --quiet-build app-eselect/eselect-repository dev-vcs/git

# Enable and sync GURU overlay
RUN eselect repository enable guru
RUN emerge --sync guru

# Install gentoo-update dependencies
RUN echo 'dev-python/sendgrid ~amd64' >> /etc/portage/package.accept_keywords/gentoo_update
RUN echo 'dev-python/python-http-client ~amd64 ~amd64' >> /etc/portage/package.accept_keywords/gentoo_update
RUN echo 'dev-python/starkbank-ecdsa ~amd64' >> /etc/portage/package.accept_keywords/gentoo_update
RUN emerge --quiet-build app-portage/gentoolkit app-admin/needrestart dev-python/sendgrid

# Install dependencies for testing
RUN emerge --quiet-build dev-python/pip dev-python/build
RUN echo "alias pb='python -m pip install . --break-system-packages'" >> ~/.bashrc
