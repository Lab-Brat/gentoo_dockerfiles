# Gentoo Linux image with 1 week old Portage source tree
FROM gentoo/stage3

# Sync Portage source tree and install Git
RUN emerge --sync
RUN emerge --quiet --update --newuse dev-vcs/git

# Set up an old Portage source tree
RUN rm -rf /var/db/repos/gentoo
RUN git clone --depth 1000 \
    https://github.com/gentoo-mirror/gentoo.git \
    /var/db/repos/gentoo

# Get commit hash of 1 week old repository state
RUN  cd /var/db/repos/gentoo \
  && git checkout stable \
  && git reset --hard $(git rev-list -n 1 --before="1 week ago" stable)

# Replace rsync with git in repos.conf
RUN mkdir '/etc/portage/repos.conf'
RUN echo -e "[DEFAULT]\n\
main-repo = gentoo\n\
\n\
[gentoo]\n\
location = /var/db/repos/gentoo\n\
sync-type = git\n\
sync-uri = https://github.com/gentoo-mirror/gentoo.git" \
> /etc/portage/repos.conf/gentoo.conf

# Install gentoo_update ependencies
RUN emerge --quiet-build y app-portage/gentoolkit app-admin/needrestart

# Install testing dependencies
RUN emerge --quiet-build y dev-python/pip dev-python/build

