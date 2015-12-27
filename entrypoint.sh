#!/bin/bash
set -e

chown -R admin /var/lib/inboxapp

exec gosu admin "$@"
