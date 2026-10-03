package graphene

// One typed pin per hand fix (docs/PATCHED.md). A regeneration that drops or changes a
// patched declaration fails to compile here.

// graphene_simd4f_t is an SSE __m128 in the C ABI: passed and returned in one XMM register,
// 16-byte aligned. A struct of four floats is neither.
@(private)
patched_simd4f_t: #simd[4]f32 = simd4f_t{}
// Out-parameters (res) are one object, not a multi-pointer.
@(private)
_pin_vec3_cross: proc "c" (a: ^vec3_t, b: ^vec3_t, res: ^vec3_t) = vec3_cross

@(private)
_pin_matrix_init_rotate: proc "c" (m: ^matrix_t, angle: f32, axis: ^vec3_t) -> ^matrix_t = matrix_init_rotate

@(private)
_pin_matrix_multiply: proc "c" (a: ^matrix_t, b: ^matrix_t, res: ^matrix_t) = matrix_multiply

@(private)
_pin_matrix_transform_point: proc "c" (m: ^matrix_t, p: ^point_t, res: ^point_t) = matrix_transform_point

@(private)
_pin_matrix_translate: proc "c" (m: ^matrix_t, pos: ^point3d_t) = matrix_translate

@(private)
_pin_rect_union: proc "c" (a: ^rect_t, b: ^rect_t, res: ^rect_t) = rect_union

@(private)
_pin_quaternion_slerp: proc "c" (a: ^quaternion_t, b: ^quaternion_t, factor: f32, res: ^quaternion_t) = quaternion_slerp

@(private)
_pin_box_union: proc "c" (a: ^box_t, b: ^box_t, res: ^box_t) = box_union

@(private)
_pin_triangle_get_uv: proc "c" (t: ^triangle_t, p: ^point3d_t, uv_a: ^vec2_t, uv_b: ^vec2_t, uv_c: ^vec2_t, res: ^vec2_t) -> b8 = triangle_get_uv

