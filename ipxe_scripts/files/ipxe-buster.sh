#!/bin/sh

# FIXME: Lots of duplication with stretch. Is that necessary?

set -e

usage() {
    echo "$0: <public ssh key file> (--vga)"
    exit 1
}

[ "$#" -lt 1 ] && usage

PUBKEYFILE=$1

CONSOLE="console=ttyS0,115200n8"

# console = "" is fine on Debian Stretch, but on Buster the frame buffer seems broken, so we disable it explicitly.
[ "$2" = "--vga" ] && CONSOLE="nomodeset"

# TODO: Strip comment off SSH key?

# Modify preseed.cfg to include our SSH key. Upload to pasta.cf
PRESEEDFILE=$(mktemp)

chmod 600 "$PRESEEDFILE"

PUBKEY=$(cat "$PUBKEYFILE")
PASSWORD=$(pwgen -s 40 1)

PRESEEDSOURCE="/usr/local/share/ipxe-buster.debian_preseed"

# Work relatively as well for sporespawn.sh
[ -f "$PRESEEDSOURCE" ] || PRESEEDSOURCE="salt/hedron/ipxe_scripts/files/ipxe-buster.debian_preseed"

sed "s|SSHKEY|$PUBKEY|" "$PRESEEDSOURCE" | sed "s/PASSWORD/$PASSWORD/" > "$PRESEEDFILE"

CHECKSUM=$(md5sum "$PRESEEDFILE" | awk '{print $1}')

PRESEED=$(pasteit < "$PRESEEDFILE")

STARTUPSCRIPT=$(mktemp)

chmod 600 "$STARTUPSCRIPT"

# shellcheck disable=SC2016
# shellcheck disable=SC2086
# Inject URL into iPXE script
echo '#!ipxe

dhcp

set mirror http://ftp.debian.org/debian/dists/buster/main/installer-amd64/current/images/netboot/debian-installer/amd64

kernel ${mirror}/linux '$CONSOLE' net.ifnames=0 netcfg/choose_interface=eth0 initrd=initrd.gz auto=true priority=critical hostname=buster auto url='$PRESEED' preseed-md5='$CHECKSUM'
initrd ${mirror}/initrd.gz
boot' > "$STARTUPSCRIPT"

cat "$STARTUPSCRIPT"

unlink "$STARTUPSCRIPT"
unlink "$PRESEEDFILE"
