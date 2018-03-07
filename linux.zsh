# Note: Windows subsystem for Linux does not currently apply umask properly.
if [ "$(umask)" = "0000" ]; then
    umask 022
fi
