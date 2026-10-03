#!/usr/bin/env bash
# Rewrites runic's output where runic gets Odin wrong. Run by `make generate` after runic,
# once per package: scripts/postprocess.sh graphene. Deterministic: the same runic output
# always gives the same file. Every rule is listed in docs/PATCHED.md.
#
# The rules follow odin-glib's (scripts/postprocess.sh), plus the SIMD vector below.
set -euo pipefail

pkg=${1:?usage: postprocess.sh graphene}
file="$pkg/$pkg.odin"
[ -f "$file" ] || { echo "postprocess: $file not found" >&2; exit 2; }

case "$pkg" in
graphene)
    # SC2016: the backticks are literal text in the generated file.
    # shellcheck disable=SC2016
    sed -i "$file" \
        -e '/^simd4f_t :: struct {$/,/^}$/c\simd4f_t :: #simd[4]f32' \
        -e '/^\(MAJOR\|MINOR\|MICRO\)_VERSION ::/ s/[`()]//g' \
        -e '/^PI\(_2\)\? ::/ {s/`//g; s/f$//}' \
        -e '/^TYPE_/ {s/`//g; s/(graphene_//; s/ ())//}' \
        -e 's/gobj\.GType/gobj.Type/g' \
        -e 's#^\([a-z][a-z_0-9]*\)\s*::\s*_graphene_\1$##' \
        -e 's#\b_graphene_\([a-z]\)#\1#g'
    ;;
*)
    echo "postprocess: unknown package $pkg" >&2
    exit 2
    ;;
esac

