PKG_NAME="z83-wifi"
PKG_VERSION="1"
PKG_LICENSE="custom"
PKG_SITE="local"
PKG_URL=""
PKG_SECTION="oem"
PKG_SHORTDESC="MINIX Z83-4: brcmfmac43455 board-file alias + auto-enable Wi-Fi"
PKG_LONGDESC="Installs brcmfmac43455 board-file aliases for MINIX Z83-4 variants and enables Wi-Fi at boot."
PKG_TOOLCHAIN="manual"

makeinstall_target() {
  local dst="$INSTALL/usr/lib/firmware/brcm"
  mkdir -p "$dst" \
           "$INSTALL/usr/lib/systemd/system" \
           "$INSTALL/usr/lib/systemd/system-preset" \
           "$INSTALL/usr/lib/libreelec"

  # firmware blobs you vendored
  install -m 0644 "$PKG_DIR/files/usr/lib/firmware/brcm/brcmfmac43455-sdio.bin"      "$dst/"
  install -m 0644 "$PKG_DIR/files/usr/lib/firmware/brcm/brcmfmac43455-sdio.clm_blob" "$dst/"
  install -m 0644 "$PKG_DIR/files/usr/lib/firmware/brcm/brcmfmac43455-sdio.txt"      "$dst/"

  # create the exact MINIX alias (avoid storing spacey names in git)
  ln -sf "brcmfmac43455-sdio.bin"  "$dst/brcmfmac43455-sdio.MINIX -Z83-4 Pro.bin"
  cp -f  "$dst/brcmfmac43455-sdio.txt" "$dst/brcmfmac43455-sdio.MINIX -Z83-4 Pro.txt"

  # oneshot to enable Wi-Fi after install/reset
  install -m 0755 "$PKG_DIR/files/usr/lib/libreelec/z83-wifi-autoon.sh" \
                   "$INSTALL/usr/lib/libreelec/"
  install -m 0644 "$PKG_DIR/files/usr/lib/systemd/system/z83-wifi-autoon.service" \
                   "$INSTALL/usr/lib/systemd/system/"
  echo "enable z83-wifi-autoon.service" > \
       "$INSTALL/usr/lib/systemd/system-preset/90-z83-wifi.preset"
}
