#!/system/bin/sh
export PATH=/data/nemesis/bin:/sbin:/vendor/bin:/system/sbin:/system/bin:/system/xbin
. ./scripts/common.sh

log "preuninstall enhanced.projection"
if ! restore_all; then
    log "keeping $BACKUP_DIR"
    exit 1
fi
remove_backup_dir || exit 1
log "removed $BACKUP_DIR"
sync
# Mirror postinstall: the restored stock APKs need a dexopt reboot, and the
# cleared projection apps reinitialize cleanly at boot. Without this the
# force-stopped apps cold-restart mid-session against wiped dalvik caches.
sync
log "rebooting so Dalvik dexopts the restored stock APKs"
exec /system/bin/reboot
log "FAIL: reboot returned"
exit 1
