PKG_NAME="z83-wifi"
PKG_VERSION="1"
PKG_LICENSE="custom"
PKG_SITE="local"
PKG_URL=""
PKG_SECTION="oem"
PKG_SHORTDESC="MINIX Z83-4: brcmfmac43455 board-file alias + auto-enabled Wi-Fi"
PKG_LONGDESC="Installs brcmfmac43455 board-file aliases for MINUX Z83-4 variants and enables Wi-Fi at boot."

makeinstall_target() {
    mkdir -p $INSTALL/usr/lib/firmware/brcm
    mkdir -p $INSTALL/usr/lib/systemd/system
    mkdir -p $INSTALL/usr/lib/systemd/system-preset
    mkdir -p $INSTALL/usr/lib/libreelec

    cp -a $PKG_DIR/files/usr/lib/firmware/brcm/* $INSTALL/usr/lib/firmware/brcm/
    cp -a $PKG_DIR/files/usr/lib/systemd/system/* $INSTALL/usr/lib/systemd/system/
    cp -a $PKG_DIR/files/usr/lib/libreelec/* $INSTALL/usr/lib/libreelec

    echo "enable z83-wifi-autoon.service" > $INSTALL/usr/lib/systemd/system-preset/90-z83-wifi.preset

    ln -sf brcmfmac43455-sdio.bin "$INSTALL/usr/lib/firmware/brcm/brcmfmac43455-sdio.MINIX -Z83-4 Pro.bin"
}
