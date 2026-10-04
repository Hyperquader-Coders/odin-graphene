#!/usr/bin/env bash
# Regenerate every package: runic over rune.yml, then the post-processing rules.
# RUNIC is the runic binary; make generate passes it.
set -euo pipefail

runic=${RUNIC:?RUNIC is not set}
cd "$(dirname "$0")/.."
mkdir -p build
ln -sfn / build/sys   # the rune files reach the system headers through build/sys/usr/include

# shellcheck disable=SC2043  # one package; the loop keeps the layout of the sibling bindings
for p in graphene; do
    echo "== generate $p =="
    rm -f "$p/$p.odin"
    (cd "$p" && env -u DISPLAY -u WAYLAND_DISPLAY "$runic" rune.yml)
    scripts/postprocess.sh "$p"
done
