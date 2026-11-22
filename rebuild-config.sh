#!/bin/sh
set -eu

if [ $# -lt 1 ]; then
    echo "Usage: $0 <host>" >&2
    exit 1
fi

host="$1"
nixos-rebuild switch --flake "$(pwd)#${host}" --sudo
