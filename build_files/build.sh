#!/bin/bash

set -ouex pipefail

### Install packages
# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/43/x86_64/repoview/index.html&protocol=https&redirect=1

# Install Fedora packages:
dnf5 install -y bat blackbox-terminal btrfs-assistant fd-find gamescope lsd lutris npm procs ripgrep steam trash-cli zoxide

# Install Node packages:
# npm i -g @continuedev/cli

# Uninstall Fedora packages:
#dnf5 remove -y malcontent
dnf5 remove -y ptyxis

# Enable COPR repos and install COPR packages:
dnf copr enable -y atim/bottom
dnf copr enable -y lihaohong/yazi
dnf5 install -y bottom yazi

# Add docker repo and install packages:
dnf5 config-manager -y addrepo --from-repofile https://download.docker.com/linux/fedora/docker-ce.repo
dnf5 install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Add vscodium repo and install packages:
tee -a /etc/yum.repos.d/vscodium.repo << 'EOF'
[gitlab.com_paulcarroty_vscodium_repo]
name=gitlab.com_paulcarroty_vscodium_repo
baseurl=https://paulcarroty.gitlab.io/vscodium-deb-rpm-repo/rpms/
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg
metadata_expire=1h
EOF
dnf5 install -y codium

# Install flatpak packages:
flatpak install -y be.alexandervanhee.gradia
flatpak install -y ca.desrt.dconf-editor
flatpak install -y com.bitwarden.desktop
flatpak install -y com.discordapp.Discord
flatpak install -y com.github.Matoking.protontricks
flatpak install -y com.github.tchx84.Flatseal
flatpak install -y com.mastermindzh.tidal-hifi
flatpak install -y com.mattjakeman.ExtensionManager
flatpak install -y com.nextcloud.desktopclient.nextcloud
flatpak install -y com.protonvpn.www
flatpak install -y com.rustdesk.RustDesk
flatpak install -y com.vysp3r.ProtonPlus
flatpak install -y io.github.flattool.Ignition
flatpak install -y io.github.flattool.Warehouse
flatpak install -y io.github.pwr_solaar.solaar
flatpak install -y io.github.realmazharhussain.GdmSettings
flatpak install -y io.gitlab.librewolf-community
flatpak install -y me.proton.Mail
flatpak install -y net.cozic.joplin_desktop
flatpak install -y org.deluge_torrent.deluge
flatpak install -y org.jellyfin.JellyfinDesktop
flatpak install -y org.libreoffice.LibreOffice
flatpak install -y org.openrgb.OpenRGB
flatpak install -y page.tesk.Refine

# Disable COPRs so they don't end up enabled on the final image:
# dnf5 copr disable -y ublue-os/staging

#### Example for enabling a System Unit File
systemctl enable podman.socket
