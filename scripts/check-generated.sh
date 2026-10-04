#!/usr/bin/env bash
# Fails when one of runic 0.8's three known faults is back in the generated files. The fork
# (`parameters: declared`, skipped va_list procedures) prevents them; this proves it:
#   1. a #c_vararg procedure that stands for a C function taking a va_list (runic drops the
#      va_list and marks the procedure `#c_vararg ..any`, which is a wrong call);
#   2. a corrected parameter typed as runic wrote it (`[^]T` for a pointer to one object);
#   3. a `[^]^T` parameter (`T **` out-parameter for one pointer) that is not a listed vector.
# `scripts/check-generated.sh --list` prints the corrected parameters. Run by `make check-generated` (in `make lint`).
set -euo pipefail
cd "$(dirname "$0")/.."

# Procedures removed from the output because their C declaration takes a va_list.
removed_valist=""

# What a generic va_list procedure looks like, by its name or link_name.
valist_pattern='_valist|_va_list|vprintf|vsnprintf|vsprintf|vasprintf|_vfprintf|_logv|_vscanf'

# Corrected parameters, one per line: package, procedure (Struct.field for a struct field),
# parameter (-> for the return type), and what the type must start with:
#   ^      pointer to one object; runic wrote [^]T
#   ^^     out-parameter for one pointer (T **); runic wrote [^]^T
#   ^[^]   out-parameter for a run (T **, an array comes back); runic wrote [^]^T
#   [^]    a run (a byte buffer, a log-attr array) that runic wrote as ^T
# Every other [^] parameter whose name ends in "s" was read against the C header and is a run.
corrected() {
    cat <<'LIST'
graphene vec2_add res ^
graphene vec2_subtract res ^
graphene vec2_multiply res ^
graphene vec2_divide res ^
graphene vec2_normalize res ^
graphene vec2_scale res ^
graphene vec2_negate res ^
graphene vec2_min res ^
graphene vec2_max res ^
graphene vec2_interpolate res ^
graphene vec3_add res ^
graphene vec3_subtract res ^
graphene vec3_multiply res ^
graphene vec3_divide res ^
graphene vec3_cross res ^
graphene vec3_normalize res ^
graphene vec3_scale res ^
graphene vec3_negate res ^
graphene vec3_min res ^
graphene vec3_max res ^
graphene vec3_interpolate res ^
graphene vec3_get_xy res ^
graphene vec3_get_xy0 res ^
graphene vec3_get_xyz0 res ^
graphene vec3_get_xyz1 res ^
graphene vec3_get_xyzw res ^
graphene vec4_add res ^
graphene vec4_subtract res ^
graphene vec4_multiply res ^
graphene vec4_divide res ^
graphene vec4_normalize res ^
graphene vec4_scale res ^
graphene vec4_negate res ^
graphene vec4_min res ^
graphene vec4_max res ^
graphene vec4_interpolate res ^
graphene vec4_get_xy res ^
graphene vec4_get_xyz res ^
graphene matrix_init_rotate axis ^
graphene matrix_get_row res ^
graphene matrix_multiply res ^
graphene matrix_transform_vec4 res ^
graphene matrix_transform_vec3 res ^
graphene matrix_transform_point res ^
graphene matrix_transform_point3d res ^
graphene matrix_transform_rect res ^
graphene matrix_transform_bounds res ^
graphene matrix_transform_sphere res ^
graphene matrix_transform_box res ^
graphene matrix_transform_ray res ^
graphene matrix_project_point res ^
graphene matrix_project_rect_bounds res ^
graphene matrix_project_rect res ^
graphene matrix_untransform_point bounds ^
graphene matrix_untransform_point res ^
graphene matrix_untransform_bounds bounds ^
graphene matrix_untransform_bounds res ^
graphene matrix_unproject_point3d res ^
graphene matrix_translate pos ^
graphene matrix_rotate axis ^
graphene matrix_transpose res ^
graphene matrix_inverse res ^
graphene matrix_perspective res ^
graphene matrix_normalize res ^
graphene matrix_interpolate res ^
graphene point_interpolate res ^
graphene size_scale res ^
graphene size_interpolate res ^
graphene rect_normalize_r res ^
graphene rect_union res ^
graphene rect_intersection res ^
graphene rect_offset_r res ^
graphene rect_inset_r res ^
graphene rect_round res ^
graphene rect_round_extents res ^
graphene rect_interpolate res ^
graphene rect_expand res ^
graphene rect_scale res ^
graphene point3d_scale res ^
graphene point3d_cross res ^
graphene point3d_normalize res ^
graphene point3d_interpolate res ^
graphene point3d_normalize_viewport res ^
graphene quaternion_init_from_angle_vec3 axis ^
graphene quaternion_to_vec4 res ^
graphene quaternion_to_angle_vec3 axis ^
graphene quaternion_invert res ^
graphene quaternion_normalize res ^
graphene quaternion_slerp res ^
graphene quaternion_multiply res ^
graphene quaternion_scale res ^
graphene quaternion_add res ^
graphene euler_to_vec3 res ^
graphene euler_to_matrix res ^
graphene euler_to_quaternion res ^
graphene euler_reorder res ^
graphene plane_normalize res ^
graphene plane_negate res ^
graphene plane_transform res ^
graphene sphere_translate res ^
graphene box_expand res ^
graphene box_expand_vec3 res ^
graphene box_expand_scalar res ^
graphene box_union res ^
graphene box_intersection res ^
graphene triangle_get_midpoint res ^
graphene triangle_get_normal res ^
graphene triangle_get_plane res ^
graphene triangle_get_bounding_box res ^
graphene triangle_get_barycoords res ^
graphene triangle_get_uv res ^
graphene ray_get_closest_point_to_point res ^
LIST
}

if [ "${1:-}" = --list ]; then
    corrected
    exit 0
fi

fail=0

# 1. va_list procedures.
files=$(git ls-files '*.odin' | grep -Ev '(_test|/patched)\.odin$' || true)
[ -n "$files" ] || { echo "check-generated: no .odin files found" >&2; exit 2; }
# shellcheck disable=SC2086
hits=$(VALIST="$valist_pattern" REMOVED="$removed_valist" perl -ne '
    BEGIN { $re = $ENV{VALIST}; %gone = map { $_ => 1 } split " ", $ENV{REMOVED}; }
    $name = $1 if /^\s*(\w+) :: /;
    $link = $1 if /link_name = "(\w+)"/;
    if (/^\s*(\w+) :: / && $gone{$1}) { print "$ARGV:$.: $1 is a removed va_list procedure\n" }
    if (/#c_vararg/ && ($name =~ /$re/ || ($link // "") =~ /$re/)) {
        print "$ARGV:$.: $name takes a va_list and is bound as #c_vararg ..any\n" }
    $link = "" if /^\s*\w+ :: /;
    close ARGV if eof;
' $files)
if [ -n "$hits" ]; then
    echo "$hits"
    echo "check-generated: a va_list procedure must be skipped by runic; check ../runic is the amber-patched build"
    fail=1
fi

# 2. Corrected parameters.
while read -r pkg proc param want; do
    [ -n "$pkg" ] || continue
    file="$pkg/$pkg.odin"
    if ! msg=$(PROC="$proc" PARAM="$param" WANT="$want" perl -e '
        my ($proc, $param, $want) = @ENV{qw(PROC PARAM WANT)};
        my ($struct, $field) = split /\./, $proc;
        my $in = 0; my $seen = 0;
        while (<>) {
            if (defined $field) {
                $in = 1 if /^\Q$struct\E :: (?:#type )?struct/;
                if ($in && /^\}/) { $in = 0 }
                next unless $in && /^\s+\Q$field\E: (.*?),?\s*$/;
                $type = $1;
            } else {
                next unless /^\s*(?:\@\(.*?\)\s*)?\Q$proc\E :: /;
                if ($param eq "->") { next unless /-> (\S+)\s*(?:---)?\s*$/; $type = $1 }
                else { next unless /[(, ]\Q$param\E: ([^,)]+)/; $type = $1 }
            }
            $seen = 1;
            if (substr($type, 0, length $want) ne $want or ($want eq "^" and $type =~ /^\^[\[\^]/)) {
                print "$proc $param is typed $type, want $want\n"; exit 1 }
            last;
        }
        unless ($seen) { print "$proc $param not found\n"; exit 1 }
    ' "$file"); then
        echo "$file: $msg"
        fail=1
    fi
done < <(corrected | grep .)

# 3. A `[^]^T` parameter is runic's spelling of `T **`. It is right only for a counted vector of
# pointers; an out-parameter that returns one pointer is `^^T` (runic 0.8's third fault). Every
# such parameter was read against the C header; the vectors are listed here, one per line:
# procedure, parameter. A `^[^]^T` (the out-array itself) is not matched.
pointer_vectors() {
    cat <<'LIST'
LIST
}
# shellcheck disable=SC2086
vec_hits=$(VECTORS="$(pointer_vectors | grep . || true)" perl -ne '
    BEGIN { for (split /\n/, $ENV{VECTORS}) { $ok{$_} = 1 } }
    $proc = $1 if /^\s*(\w+) :: /;
    while (/(?<![\^\w])(\w+): \[\^\]\^/g) {
        print "$ARGV:$.: $proc $1 is [^]^T; use ^^T for an out-parameter, or list it in pointer_vectors if it is a counted vector\n"
            unless $ok{"$proc $1"};
    }
    close ARGV if eof;
' $files)
if [ -n "$vec_hits" ]; then
    echo "$vec_hits"
    fail=1
fi

if [ "$fail" -ne 0 ]; then
    echo "check-generated: runic's output regressed; check rune.yml (parameters: declared) and run make generate"
    exit 1
fi
echo "check-generated: OK"
