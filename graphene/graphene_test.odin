#+test
package graphene

import "core:math"
import "core:strings"
import "core:testing"
import gobj "glib:gobject"

// Version recorded in README.md: "**Bound version:** X.Y.Z".
README :: #load("../README.md", string)

bound_version :: proc() -> (major, minor, micro: int, ok: bool) {
    marker :: "**Bound version:** "
    readme := README
    i := strings.index(readme, marker)
    if i < 0 do return
    rest := readme[i + len(marker):]
    end := strings.index_any(rest, " \n")
    if end < 0 do return
    parts := strings.split(rest[:end], ".", context.temp_allocator)
    if len(parts) != 3 do return
    nums: [3]int
    for p, n in parts {
        v := 0
        if len(p) == 0 do return
        for c in p {
            if c < '0' || c > '9' do return
            v = v * 10 + int(c - '0')
        }
        nums[n] = v
    }
    return nums[0], nums[1], nums[2], true
}

@(test)
test_readme_version_matches_header_macros :: proc(t: ^testing.T) {
    major, minor, micro, ok := bound_version()
    testing.expect(t, ok, "README.md has no '**Bound version:** X.Y.Z'")
    testing.expect_value(t, major, MAJOR_VERSION)
    testing.expect_value(t, minor, MINOR_VERSION)
    testing.expect_value(t, micro, MICRO_VERSION)
}

@(test)
test_simd_type_matches_the_c_abi :: proc(t: ^testing.T) {
    testing.expect_value(t, size_of(simd4f_t), 16)
    testing.expect_value(t, align_of(simd4f_t), 16)
    testing.expect_value(t, size_of(vec3_t), 16)
    testing.expect_value(t, align_of(vec3_t), 16)
    testing.expect_value(t, size_of(matrix_t), 64)
    testing.expect_value(t, size_of(box_t), 32)
    testing.expect_value(t, size_of(rect_t), 16)
}

@(test)
test_vec3_arithmetic :: proc(t: ^testing.T) {
    a, b, c: vec3_t
    vec3_init(&a, 1, 2, 2)
    vec3_init(&b, 3, 0, 4)
    testing.expect_value(t, vec3_length(&a), 3)
    testing.expect_value(t, vec3_dot(&a, &b), 11)
    vec3_cross(&a, &b, &c)
    testing.expect_value(t, vec3_get_x(&c), 8)
    testing.expect_value(t, vec3_get_y(&c), 2)
    testing.expect_value(t, vec3_get_z(&c), -6)
    vec3_add(&a, &b, &c)
    testing.expect_value(t, vec3_get_z(&c), 6)
}

@(test)
test_simd_values_pass_in_registers :: proc(t: ^testing.T) {
    s := simd4f_init(1, 2, 3, 4)
    testing.expect_value(t, simd4f_get_x(s), 1)
    testing.expect_value(t, simd4f_get_w(s), 4)
    sum := simd4f_add(s, simd4f_splat(10))
    testing.expect_value(t, simd4f_get_y(sum), 12)
    testing.expect_value(t, simd4f_get_z(sum), 13)
    testing.expect_value(t, simd4f_dot3_scalar(s, s), 14)
}

@(test)
test_matrix_transforms_a_point :: proc(t: ^testing.T) {
    m: matrix_t
    matrix_init_translate(&m, &point3d_t{1, 2, 3})
    p := point3d_t{10, 20, 30}
    out: point3d_t
    matrix_transform_point3d(&m, &p, &out)
    testing.expect_value(t, out, point3d_t{11, 22, 33})

    matrix_init_identity(&m)
    matrix_rotate_z(&m, 90)
    pt := point_t{1, 0}
    res: point_t
    matrix_transform_point(&m, &pt, &res)
    testing.expect(t, math.abs(res.x) < 1e-5 && math.abs(res.y - 1) < 1e-5, "a quarter turn maps (1,0) to (0,1)")
}

@(test)
test_rect_and_point_functions :: proc(t: ^testing.T) {
    r: rect_t
    rect_init(&r, 0, 0, 10, 5)
    testing.expect_value(t, rect_get_area(&r), 50)
    testing.expect(t, bool(rect_contains_point(&r, &point_t{3, 3})))
    testing.expect(t, !bool(rect_contains_point(&r, &point_t{30, 3})))
}

@(test)
test_box_and_ray_intersection :: proc(t: ^testing.T) {
    lo := point3d_t{-1, -1, -1}
    hi := point3d_t{1, 1, 1}
    b: box_t
    box_init(&b, &lo, &hi)
    origin := point3d_t{0, 0, -5}
    dir: vec3_t
    vec3_init(&dir, 0, 0, 1)
    r: ray_t
    ray_init(&r, &origin, &dir)
    dist: f32
    kind := ray_intersect_box(&r, &b, &dist)
    testing.expect_value(t, kind, ray_intersection_kind_t.ENTER)
    testing.expect(t, math.abs(dist - 4) < 1e-4, "the ray meets the box 4 units out")
}

@(test)
test_gobject_types_are_registered :: proc(t: ^testing.T) {
    types := [?]gobj.Type {
        point_get_type(), size_get_type(), rect_get_type(), vec2_get_type(), vec3_get_type(),
        vec4_get_type(), matrix_get_type(), quaternion_get_type(), euler_get_type(), ray_get_type(),
    }
    for ty in types {
        testing.expect(t, ty != 0, "a boxed type has no GType")
    }
    testing.expect_value(t, gobj.type_name(TYPE_RECT()), "GrapheneRect")
}

// `res` is one vec3_t: x cross y is z, written through a plain address.
@(test)
test_single_object_result :: proc(t: ^testing.T) {
    x, y, z: vec3_t
    vec3_init(&x, 1, 0, 0)
    vec3_init(&y, 0, 1, 0)
    vec3_cross(&x, &y, &z)
    testing.expect_value(t, vec3_get_x(&z), 0)
    testing.expect_value(t, vec3_get_z(&z), 1)
}
