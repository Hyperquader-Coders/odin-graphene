# Decisions — odin-graphene

Settled choices. An entry that stops being true is rewritten, not appended to.

## 1. Generated, not hand-written

The bindings are generated with runic from the headers Amber ships, so a library bump is a
regeneration. Hand fixes are the exception and are tracked in [PATCHED.md](PATCHED.md).

## 2. `simd4f_t` is `#simd[4]f32`

On x86_64 Graphene builds with SSE, where `graphene_simd4f_t` is `__m128`: one XMM register
as an argument or result, 16-byte aligned. runic is given a struct of four floats instead (it
cannot read a vector type), and the System V ABI passes that struct in two registers and
aligns it to 4. Every `simd4f_*` call would read the wrong registers, and a `vec3_t` on the
stack could sit unaligned where Graphene's own code expects 16. `scripts/postprocess.sh`
rewrites the type to `#simd[4]f32`; the test checks sizes, alignment and a round trip through
the exported `simd4f_*` procedures. Binding the type as a struct, or as `[4]f32`, was
rejected for the ABI. The rule and its pin are in [PATCHED.md](PATCHED.md).

## 3. One package, GObject types included

`graphene-gobject.h` is the rune file's entry point, so the `*_get_type` procedures are bound
with GLib's `Type` from `glib:gobject`, and `TYPE_RECT` and its siblings name them as in
odin-glib's GIO. A second package would only split 17 procedures from the types they describe.
`GRAPHENE_*_VERSION` stays out; `MAJOR_VERSION`, `MINOR_VERSION` and `MICRO_VERSION` stay for
the version test.

## 4. The SSE intrinsics header is a stub

`graphene-config.h` includes `xmmintrin.h` for `__m128`, which runic's libclang cannot find.
`stdinc/xmmintrin.h` and `stdinc/emmintrin.h` supply the type; `rune.yml` overwrites
`graphene_simd4f_t`, so nothing else from them is used.

## 5. Parameters are single objects unless declared

runic 0.8 writes `[^]T` for a pointer parameter whose C name ends in `s` (`settings`, `lines`),
however many elements it holds, which lets a caller index past one element, and drops a trailing
`va_list`, binding the procedure as `#c_vararg ..any`. Amber's runic fork (branch `amber-patched`)
has `parameters: declared`: with it every procedure parameter is `^T` (`T **` is `^^T`) unless
`arrays:` in the package's `rune.yml` lists it, chosen against the C headers, and a va_list
procedure is skipped. Struct members, variables and typedefs keep runic's name guess, and the
parameters of function-pointer types are plain `^T`: a limit of the fork, true in every binding.
Where a binding needs it, the `param_rules` table in `postprocess.sh` restores the `[^]` for
those parameters' real arrays, rewrites single-object struct members and corrects `T ***` outs;
a row that matches nothing fails the build. Rejected: rewriting the output in `postprocess.sh`,
which had to be told each parameter, matched `va_list` procedures by name pattern (it deleted
`list_store_insert_with_values` for containing `_va`) and was a second place to keep in step
with the headers. `scripts/check-generated.sh` stays as the guard that any regeneration, with
any runic, keeps the listed parameters right.
