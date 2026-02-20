#!/bin/bash

set -ouex pipefail

### Install packages
# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/43/x86_64/repoview/index.html&protocol=https&redirect=1

# Install Fedora packages:
dnf5 install -y bat blackbox-terminal fd-find lsd ripgrep trash-cli zoxide
# Uninstall Fedora packages:
dnf5 remove -y malcontent ptyxis waydroid

# Install COPR packages:
# dnf5 copr enable -y ublue-os/staging
# dnf5 install -y package
dnf copr enable -y atim/bottom
dnf copr enable -y lihaohong/yazi
dnf5 install -y bottom yazi

# Disable COPRs so they don't end up enabled on the final image:
# dnf5 copr disable -y ublue-os/staging

#### Example for enabling a System Unit File
systemctl enable podman.socket
