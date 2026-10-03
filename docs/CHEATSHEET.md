# odin-graphene cheat sheet

One screen per job: the calls a program makes, in the order it makes them, and the few rules
worth remembering. Graphene is a small maths library, but a program needs only its geometry
and its matrices; this is that part. Every name here is a public declaration in
[API.md](API.md), and `make lint` fails when one is not. Every code block is compiled against
the binding before it is committed.

Conventions that hold everywhere: the `graphene_` prefix is dropped, so `graphene_rect_init` is
`graphene.rect_init`; types end in `_t`; every number is `f32`; an `_init` procedure fills a
value you own and returns the same pointer; a `res` parameter is the result, written in place
(`rect_union(&a, &b, &out)`); a `_r` suffix is the same operation with a result instead of
changing its argument; a question returns `b8`.

## graphene:graphene — points, sizes and rectangles

```odin
import "graphene:graphene"

p := graphene.point_t{10, 20}                      // a plain struct of two f32: build it, copy it, no free
sz := graphene.size_t{200, 100}
r := graphene.rect_t{origin = p, size = sz}        // GTK wants one of these for every draw call
r2 := graphene.rect_t{{0, 0}, {50, 50}}
graphene.rect_init(&r, 0, 0, 100, 40)              // or fill one in place: x, y, width, height

x := r.origin.x                                    // the fields are public
w := graphene.rect_get_width(&r)                   // the getter normalises a negative width

if graphene.rect_contains_point(&r, &p) { }        // b8
c: graphene.point_t
graphene.rect_get_center(&r, &c)                   // out-parameter: the centre goes into c
area := graphene.rect_get_area(&r)

both: graphene.rect_t
if graphene.rect_intersection(&r, &r2, &both) { }  // false when they do not overlap
all: graphene.rect_t
graphene.rect_union(&r, &r2, &all)                 // the bounding box

graphene.rect_offset(&r, 5, 5)                     // in place; rect_offset_r writes to a result
graphene.rect_inset(&r, 2, 2)                      // negative values grow it
graphene.rect_normalize(&r)                        // makes width and height positive

near := graphene.point_near(&p, &c, 0.5)           // within an epsilon
d := graphene.point_distance(&p, &c, nil, nil)
```

| remember | |
|---|---|
| `point_t`, `size_t` and `rect_t` are value types | build them with a literal; there is no `init` to forget and nothing to free |
| `point_alloc`, `rect_alloc` and the other `_alloc` calls are for C | they return heap values to release with `_free`; from Odin a local variable does the job |
| `rect_t` is `{origin, size}` | `r.origin.x`, `r.size.width`, not `r.x`; `{{x, y}, {w, h}}` in a literal |
| A result goes in the last parameter | pass `&out`, a variable of the result's type; `matrix_inverse` and `rect_intersection` also return whether there was one |
| Booleans are `b8` | `if graphene.rect_contains_point(...)` works; compare with `bool(...)` when mixing with an Odin `bool` |

## graphene:graphene — vectors and matrices

```odin
import "graphene:graphene"

m: graphene.matrix_t                               // on the stack: the SIMD fields keep it 16-byte aligned
graphene.matrix_init_identity(&m)                  // always initialise: a zeroed matrix is singular, an uninitialised one is garbage
t := graphene.point3d_t{10, 20, 0}
graphene.matrix_init_translate(&m, &t)             // or start from a translation
graphene.matrix_rotate_z(&m, 45)                   // degrees, not radians
graphene.matrix_scale(&m, 2, 2, 1)                 // each call multiplies onto m, in order

a, b, both: graphene.matrix_t
graphene.matrix_init_identity(&a)
graphene.matrix_init_scale(&b, 2, 2, 1)
graphene.matrix_multiply(&a, &b, &both)            // the result goes into the last parameter

p := graphene.point_t{1, 2}
out: graphene.point_t
graphene.matrix_transform_point(&m, &p, &out)      // one point
bounds: graphene.rect_t
graphene.matrix_transform_bounds(&m, &graphene.rect_t{{0, 0}, {10, 10}}, &bounds)   // a rect's bounding box

inv: graphene.matrix_t
if graphene.matrix_inverse(&m, &inv) { }           // false when it is singular
sx := graphene.matrix_get_x_scale(&m)
tx := graphene.matrix_get_x_translation(&m)

v: graphene.vec3_t
graphene.vec3_init(&v, 3, 4, 0)                    // vectors are opaque: fill them with init, read with the getters
n: graphene.vec3_t
graphene.vec3_normalize(&v, &n)
length := graphene.vec3_length(&v)

heap := graphene.matrix_alloc()                    // only when it must outlive the stack frame
defer graphene.matrix_free(heap)
graphene.matrix_init_identity(heap)
```

| remember | |
|---|---|
| `matrix_t` and `vec*_t` are opaque | their fields are `simd4f_t` (`#simd[4]f32`, [why](DECISIONS.md#2-simd4f_t-is-simd4f32)); set them only through `_init` and read them through the getters |
| Initialise before use | `matrix_init_identity` first; `matrix_translate`, `matrix_scale` and `matrix_rotate_*` change an existing matrix |
| Angles are degrees | `matrix_rotate_z(&m, 45)` |
| A `_alloc` has its `_free` | use `defer graphene.matrix_free(m)`; a stack variable needs neither |
| Copy with `=` | `b = a` copies a matrix or vector; `matrix_init_from_matrix` and its siblings are the C way |
