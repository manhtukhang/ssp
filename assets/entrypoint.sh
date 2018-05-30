#! /bin/bash
#
# entrypoint.sh
# Copyleft (ɔ) 2016 Thiago Almeida <thiagoalmeidasa@gmail.com>
#
# Distributed under terms of the GPLv2 license.
#
set -e

[[ -n $DEBUG_ENTRYPOINT ]] && set -x

## Setting up files and paths
a2dissite 000-default
a2ensite ssp
exec /usr/sbin/apache2ctl -D FOREGROUND
