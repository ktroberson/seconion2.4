{% from 'vars/globals.map.jinja' import GLOBALS %}

{# we only want this state to run it is CentOS #}
{% if GLOBALS.os == 'Rocky' %}


workstation_packages:
  pkg.installed:
    - pkgs:
      - audit
      - basesystem
      - bash
      - coreutils
      - cronie
      - crypto-policies
      - crypto-policies-scripts
      - curl
      - dnf
      - e2fsprogs
      - filesystem
      - firewalld
      - glibc
      - git
      - grubby
      - hostname
      - iproute
      - iproute-tc
      - iputils
      - irqbalance
      - kbd
      - kexec-tools
      - less
      - logrotate
      - man-db
      - ncurses
      - openssh-clients
      - openssh-server
      - p11-kit
      - parted
      - passwd
      - policycoreutils
      - procps-ng
      - rootfiles
      - rpm
      - rpm-plugin-audit
      - rsyslog
      - selinux-policy-targeted
      - setup
      - shadow-utils
      - sssd-common
      - sssd-kcm
      - sudo
      - systemd
      - util-linux
      - vim-minimal
      - xfsprogs
      - yum
      - NetworkManager
      - NetworkManager-team
      - NetworkManager-tui
      - authselect
      - dnf-plugins-core
      - dracut-config-rescue
      - initscripts-rename-device
      - iwl100-firmware
      - iwl1000-firmware
      - iwl105-firmware
      - iwl135-firmware
      - iwl2000-firmware
      - iwl2030-firmware
      - iwl3160-firmware
      - iwl5000-firmware
      - iwl5150-firmware
      - iwl6000g2a-firmware
      - iwl6050-firmware
      - iwl7260-firmware
      - kernel-tools
      - libsysfs
      - linux-firmware
      - lshw
      - lsscsi
      - microcode_ctl
      - prefixdevname
      - python3-libselinux
      - sg3_utils
      - sg3_utils-libs
      - ppp
      - abattis-cantarell-fonts
      - dejavu-sans-fonts
      - dejavu-sans-mono-fonts
      - dejavu-serif-fonts
      - google-noto-emoji-color-fonts
      - google-noto-sans-cjk-ttc-fonts
      - google-noto-sans-gurmukhi-fonts
      - google-noto-sans-sinhala-vf-fonts
      - google-noto-serif-cjk-ttc-fonts
      - jomolhari-fonts
      - julietaula-montserrat-fonts
      - khmer-os-system-fonts
      - liberation-mono-fonts
      - liberation-sans-fonts
      - liberation-serif-fonts
      - lohit-assamese-fonts
      - lohit-bengali-fonts
      - lohit-devanagari-fonts
      - lohit-gujarati-fonts
      - lohit-kannada-fonts
      - lohit-odia-fonts
      - lohit-tamil-fonts
      - lohit-telugu-fonts
      - paktype-naskh-basic-fonts
      - pt-sans-fonts
      - sil-abyssinica-fonts
      - sil-nuosu-fonts
      - sil-padauk-fonts
      - smc-meera-fonts
      - stix-fonts
      - thai-scalable-waree-fonts
      - hyperv-daemons
      - open-vm-tools-desktop
      - qemu-guest-agent
      - spice-vdagent
      - bolt
      - iwl100-firmware
      - iwl1000-firmware
      - iwl105-firmware
      - iwl135-firmware
      - iwl2000-firmware
      - iwl2030-firmware
      - iwl3160-firmware
      - iwl5000-firmware
      - iwl5150-firmware
      - iwl6000g2a-firmware
      - iwl6000g2b-firmware
      - iwl6050-firmware
      - iwl7260-firmware
      - libertas-sd8787-firmware
      - netronome-firmware
      - usb_modeswitch
      - ibus-anthy
      - ibus-hangul
      - ibus-libpinyin
      - ibus-libzhuyin
      - ibus-m17n
      - ibus-typing-booster
      - PackageKit-gstreamer-plugin
      - alsa-ucm
      - alsa-utils
      - gstreamer1-plugins-bad-free
      - gstreamer1-plugins-good
      - gstreamer1-plugins-ugly-free
      - pipewire
      - pipewire-alsa
      - pipewire-gstreamer
      - pipewire-jack-audio-connection-kit
      - pipewire-pulseaudio
      - pipewire-utils
      - acl
      - at
      - attr
      - bc
      - cpio
      - crontabs
      - cyrus-sasl-plain
      - dbus
      - ed
      - file
      - irqbalance
      - kpatch
      - kpatch-dnf
      - logrotate
      - lsof
      - mcelog
      - microcode_ctl
      - net-tools
      - pciutils
      - psacct
      - quota
      - rocky-release
      - rsyslog-gnutls
      - rsyslog-gssapi
      - rsyslog-relp
      - sudo
      - symlinks
      - systemd-udev
      - tar
      - tree
      - tuned
      - util-linux-user
      - bash-completion
      - blktrace
      - bluez
      - bpftool
      - bzip2
      - chrony
      - cockpit
      - cryptsetup
      - dos2unix
      - dosfstools
      - ethtool
      - fprintd-pam
      - gnupg2
      - iprutils
      - kmod-kvdo
      - ledmon
      - libstoragemgmt
      - lvm2
      - mailcap
      - man-pages
      - mdadm
      - mlocate
      - mtr
      - nano
      - nmap-ncat
      - nvme-cli
      - pinfo
      - plymouth
      - realmd
      - rsync
      - smartmontools
      - sos
      - sssd
      - strace
      - tcpdump
      - teamd
      - time
      - unzip
      - usbutils
      - vdo
      - vim-enhanced
      - virt-what
      - wget
      - which
      - words
      - xfsdump
      - zip
      - NetworkManager-adsl
      - NetworkManager-bluetooth
      - NetworkManager-l2tp-gnome
      - NetworkManager-libreswan-gnome
      - NetworkManager-openconnect-gnome
      - NetworkManager-openvpn-gnome
      - NetworkManager-ppp
      - NetworkManager-pptp-gnome
      - NetworkManager-wifi
      - NetworkManager-wwan
      - aajohan-comfortaa-fonts
      - anaconda
      - anaconda-install-env-deps
      - anaconda-live
      - chkconfig
      - cinnamon
      - cinnamon-control-center
      - cinnamon-screensaver
      - dracut-live
      - efi-filesystem
      - efibootmgr
      - efivar-libs
      - eom
      - f36-backgrounds-extras-gnome
      - f36-backgrounds-gnome
      - f37-backgrounds-extras-gnome
      - f37-backgrounds-gnome
      - firewall-config
      - glibc-all-langpacks
      - gnome-calculator
      - gnome-disk-utility
      - gnome-screenshot
      - gnome-system-monitor
      - gnome-terminal
      - grub2-common
      - grub2-efi-*64
      - grub2-efi-*64-cdboot
      - grub2-pc-modules
      - grub2-tools
      - grub2-tools-efi
      - grub2-tools-extra
      - grub2-tools-minimal
      - grubby
      - gstreamer1-plugins-ugly-free
      - gvfs-gphoto2
      - gvfs-mtp
      - gvfs-smb
      - imsettings-systemd
      - initial-setup-gui
      - initscripts
      - kernel
      - kernel-modules
      - kernel-modules-extra
      - lightdm
      - memtest86+
      - metacity
      - nemo-fileroller
      - nemo-image-converter
      - nemo-preview
      - nm-connection-editor
      - parole
      - pipewire-alsa
      - pipewire-pulseaudio
      - powerline
      - redshift-gtk
      - rocky-backgrounds
      - salt-minion
      - sane-backends-drivers-scanners
      - setroubleshoot
      - shim-*64
      - slick-greeter
      - slick-greeter-cinnamon
      - syslinux
      - tmux
      - tmux-powerline
      - transmission
      - vim-enhanced
      - vim-powerline
      - wireplumber
      - xdg-user-dirs-gtk
      - xed
      - xreader

desktop_remove:
  pkg.absent:
    pkgs:
      - hplip
      - isdn4k-utils
      - mpage
      - shim-unsigned-*64
      - xane-gimp
      - xsane

{% else %}

workstation_packages_os_fail:
  test.fail_without_changes:
    - comment: 'SO Analyst Workstation can only be installed on Rocky'

{% endif %}
