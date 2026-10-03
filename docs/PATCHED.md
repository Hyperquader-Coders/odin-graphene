# Patched bindings

The bindings are generated from the C headers by runic 0.8 in Amber's fork (`../runic`, branch `amber-patched`).
Regenerating overwrites hand fixes, so each is also pinned by a typed variable in the
package's `patched.odin`: a regeneration that drops a patch fails to compile there instead
of misbehaving at run time.

To regenerate, run `make generate`, re-apply every row below, and build the package.

Two things change the generated output: rules that `make generate` applies every time, and
one hand-pinned type. Regenerating applies the rules again; the pin in `graphene/patched.odin`
makes a regeneration that drops the type fix fail to compile.

## Generation rules

`scripts/postprocess.sh graphene` applies these to `graphene/graphene.odin`, in this order.

| rule | reason |
|---|---|
| `simd4f_t :: struct {x, y, z, w: f32}` becomes `simd4f_t :: #simd[4]f32` | the C type is an SSE `__m128`: one register, 16-byte aligned (DECISIONS §2) |
| `MAJOR_VERSION`, `MINOR_VERSION`, `MICRO_VERSION` lose backticks and parentheses | macro text runic quotes as a string |
| `PI`, `PI_2` lose backticks and the `f` suffix | as above |
| `TYPE_FOO :: \`(graphene_foo_get_type ())\`` becomes `TYPE_FOO :: foo_get_type` | as above; the name is the procedure, as in odin-glib's GIO |
| `gobj.GType` becomes `gobj.Type` | odin-glib trims the `G` prefix |
| `Foo :: _graphene_foo` is deleted and `_graphene_foo` becomes `foo` | one name per struct |

## Pinned

| type | pin | change |
|---|---|---|
| `simd4f_t` | `patched_simd4f_t: #simd[4]f32` | struct of four floats replaced by a vector, by the first rule above |

## Single-object parameters

| rule | why | pin |
|---|---|---|
| `parameters: declared` in `graphene/rune.yml`: `res`, `axis`, `pos` and `bounds` (`graphene_*_t *`) are `^T`, not `[^]T` | runic writes `[^]T` for any pointer parameter whose name ends in `s`, so a caller can index past one element. Read against `graphene-*.h` | `_pin_vec3_cross`, `_pin_matrix_multiply`, `_pin_matrix_transform_point`, `_pin_rect_union`, `_pin_quaternion_slerp`, `_pin_box_union`, `_pin_triangle_get_uv`, `_pin_matrix_translate`, `_pin_matrix_init_rotate` |

Listed under `arrays:` in `rune.yml`, each a real array: `points` (`sphere_init_from_points`, `box_init_from_points`) and `vectors` (`sphere_init_from_vectors`, `box_init_from_vectors`). `quad_init_from_points`, `rect_get_vertices`, `box_get_vertices` and `frustum_get_planes` take C array parameters (`T name[N]`), which runic writes `[^]T` without the heuristic. The whole list, with the `[^]` buffers kept, is in `scripts/check-generated.sh`, run by `make lint`.

## Out-parameters (`T **`)

runic writes `[^]^T` for some `T **` parameters; an out-parameter that returns one pointer must be `^^T`. Every `[^]^T` and `^[^]^T` in the generated output was read against the headers: none is a single-pointer out-parameter, so none is rewritten (under `declared` a `T **` is `^^T` anyway). `scripts/check-generated.sh` fails on any `[^]^T` that is not in its `pointer_vectors` list, so a new one is noticed on the next `make generate`.
