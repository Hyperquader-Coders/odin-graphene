# odin-graphene API

Every public declaration of every package, generated from the source by `make api`; do not
edit. The reference is the [README](../README.md); the short form is the
[cheat sheet](CHEATSHEET.md).

## graphene

```text
package graphene
	constants
		MAJOR_VERSION :: 1
		MICRO_VERSION :: 8
		MINOR_VERSION :: 10
		PI :: 3.1415926535897932384626434
		PI_2 :: 1.5707963267948966192313217
		VEC2_LEN :: 2
		VEC3_LEN :: 3
		VEC4_LEN :: 4

	procedures
		box_alloc :: proc() -> ^box_t ---
		box_contains_box :: proc(a: ^box_t, b: ^box_t) -> b8 ---
		box_contains_point :: proc(box: ^box_t, point: ^point3d_t) -> b8 ---
		box_empty :: proc() -> ^box_t ---
		box_equal :: proc(a: ^box_t, b: ^box_t) -> b8 ---
		box_expand :: proc(box: ^box_t, point: ^point3d_t, res: ^box_t) ---
		box_expand_scalar :: proc(box: ^box_t, scalar: f32, res: ^box_t) ---
		box_expand_vec3 :: proc(box: ^box_t, vec: ^vec3_t, res: ^box_t) ---
		box_free :: proc(box: ^box_t) ---
		box_get_bounding_sphere :: proc(box: ^box_t, sphere: ^sphere_t) ---
		box_get_center :: proc(box: ^box_t, center: ^point3d_t) ---
		box_get_depth :: proc(box: ^box_t) -> f32 ---
		box_get_height :: proc(box: ^box_t) -> f32 ---
		box_get_max :: proc(box: ^box_t, max: ^point3d_t) ---
		box_get_min :: proc(box: ^box_t, min: ^point3d_t) ---
		box_get_size :: proc(box: ^box_t, size: ^vec3_t) ---
		box_get_type :: proc() -> gobj.Type ---
		box_get_type :: proc() -> gobj.Type ---
		box_get_vertices :: proc(box: ^box_t, vertices: [^]vec3_t) ---
		box_get_width :: proc(box: ^box_t) -> f32 ---
		box_infinite :: proc() -> ^box_t ---
		box_init :: proc(box: ^box_t, min: ^point3d_t, max: ^point3d_t) -> ^box_t ---
		box_init_from_box :: proc(box: ^box_t, src: ^box_t) -> ^box_t ---
		box_init_from_points :: proc(box: ^box_t, n_points: u32, points: [^]point3d_t) -> ^box_t ---
		box_init_from_vec3 :: proc(box: ^box_t, min: ^vec3_t, max: ^vec3_t) -> ^box_t ---
		box_init_from_vectors :: proc(box: ^box_t, n_vectors: u32, vectors: [^]vec3_t) -> ^box_t ---
		box_intersection :: proc(a: ^box_t, b: ^box_t, res: ^box_t) -> b8 ---
		box_minus_one :: proc() -> ^box_t ---
		box_one :: proc() -> ^box_t ---
		box_one_minus_one :: proc() -> ^box_t ---
		box_union :: proc(a: ^box_t, b: ^box_t, res: ^box_t) ---
		box_zero :: proc() -> ^box_t ---
		euler_alloc :: proc() -> ^euler_t ---
		euler_equal :: proc(a: ^euler_t, b: ^euler_t) -> b8 ---
		euler_free :: proc(e: ^euler_t) ---
		euler_get_alpha :: proc(e: ^euler_t) -> f32 ---
		euler_get_beta :: proc(e: ^euler_t) -> f32 ---
		euler_get_gamma :: proc(e: ^euler_t) -> f32 ---
		euler_get_order :: proc(e: ^euler_t) -> euler_order_t ---
		euler_get_type :: proc() -> gobj.Type ---
		euler_get_type :: proc() -> gobj.Type ---
		euler_get_x :: proc(e: ^euler_t) -> f32 ---
		euler_get_y :: proc(e: ^euler_t) -> f32 ---
		euler_get_z :: proc(e: ^euler_t) -> f32 ---
		euler_init :: proc(e: ^euler_t, x: f32, y: f32, z: f32) -> ^euler_t ---
		euler_init_from_euler :: proc(e: ^euler_t, src: ^euler_t) -> ^euler_t ---
		euler_init_from_matrix :: proc(e: ^euler_t, m: ^matrix_t, order: euler_order_t) -> ^euler_t ---
		euler_init_from_quaternion :: proc(e: ^euler_t, q: ^quaternion_t, order: euler_order_t) -> ^euler_t ---
		euler_init_from_radians :: proc(e: ^euler_t, x: f32, y: f32, z: f32, order: euler_order_t) -> ^euler_t ---
		euler_init_from_vec3 :: proc(e: ^euler_t, v: ^vec3_t, order: euler_order_t) -> ^euler_t ---
		euler_init_with_order :: proc(e: ^euler_t, x: f32, y: f32, z: f32, order: euler_order_t) -> ^euler_t ---
		euler_reorder :: proc(e: ^euler_t, order: euler_order_t, res: ^euler_t) ---
		euler_to_matrix :: proc(e: ^euler_t, res: ^matrix_t) ---
		euler_to_quaternion :: proc(e: ^euler_t, res: ^quaternion_t) ---
		euler_to_vec3 :: proc(e: ^euler_t, res: ^vec3_t) ---
		frustum_alloc :: proc() -> ^frustum_t ---
		frustum_contains_point :: proc(f: ^frustum_t, point: ^point3d_t) -> b8 ---
		frustum_equal :: proc(a: ^frustum_t, b: ^frustum_t) -> b8 ---
		frustum_free :: proc(f: ^frustum_t) ---
		frustum_get_planes :: proc(f: ^frustum_t, planes: [^]plane_t) ---
		frustum_get_type :: proc() -> gobj.Type ---
		frustum_get_type :: proc() -> gobj.Type ---
		frustum_init :: proc(f: ^frustum_t, p0: ^plane_t, p1: ^plane_t, p2: ^plane_t, p3: ^plane_t, p4: ^plane_t, p5: ^plane_t) -> ^frustum_t ---
		frustum_init_from_frustum :: proc(f: ^frustum_t, src: ^frustum_t) -> ^frustum_t ---
		frustum_init_from_matrix :: proc(f: ^frustum_t, matrix_p: ^matrix_t) -> ^frustum_t ---
		frustum_intersects_box :: proc(f: ^frustum_t, box: ^box_t) -> b8 ---
		frustum_intersects_sphere :: proc(f: ^frustum_t, sphere: ^sphere_t) -> b8 ---
		matrix_alloc :: proc() -> ^matrix_t ---
		matrix_decompose :: proc(m: ^matrix_t, translate: ^vec3_t, scale: ^vec3_t, rotate: ^quaternion_t, shear: ^vec3_t, perspective: ^vec4_t) -> b8 ---
		matrix_determinant :: proc(m: ^matrix_t) -> f32 ---
		matrix_equal :: proc(a: ^matrix_t, b: ^matrix_t) -> b8 ---
		matrix_equal_fast :: proc(a: ^matrix_t, b: ^matrix_t) -> b8 ---
		matrix_free :: proc(m: ^matrix_t) ---
		matrix_get_row :: proc(m: ^matrix_t, index_: u32, res: ^vec4_t) ---
		matrix_get_type :: proc() -> gobj.Type ---
		matrix_get_type :: proc() -> gobj.Type ---
		matrix_get_value :: proc(m: ^matrix_t, row: u32, col: u32) -> f32 ---
		matrix_get_x_scale :: proc(m: ^matrix_t) -> f32 ---
		matrix_get_x_translation :: proc(m: ^matrix_t) -> f32 ---
		matrix_get_y_scale :: proc(m: ^matrix_t) -> f32 ---
		matrix_get_y_translation :: proc(m: ^matrix_t) -> f32 ---
		matrix_get_z_scale :: proc(m: ^matrix_t) -> f32 ---
		matrix_get_z_translation :: proc(m: ^matrix_t) -> f32 ---
		matrix_init_from_2d :: proc(m: ^matrix_t, xx: f64, yx: f64, xy: f64, yy: f64, x_0: f64, y_0: f64) -> ^matrix_t ---
		matrix_init_from_float :: proc(m: ^matrix_t, v: ^f32) -> ^matrix_t ---
		matrix_init_from_matrix :: proc(m: ^matrix_t, src: ^matrix_t) -> ^matrix_t ---
		matrix_init_from_vec4 :: proc(m: ^matrix_t, v0: ^vec4_t, v1: ^vec4_t, v2: ^vec4_t, v3: ^vec4_t) -> ^matrix_t ---
		matrix_init_frustum :: proc(m: ^matrix_t, left: f32, right: f32, bottom: f32, top: f32, z_near: f32, z_far: f32) -> ^matrix_t ---
		matrix_init_identity :: proc(m: ^matrix_t) -> ^matrix_t ---
		matrix_init_look_at :: proc(m: ^matrix_t, eye: ^vec3_t, center: ^vec3_t, up: ^vec3_t) -> ^matrix_t ---
		matrix_init_ortho :: proc(m: ^matrix_t, left: f32, right: f32, top: f32, bottom: f32, z_near: f32, z_far: f32) -> ^matrix_t ---
		matrix_init_perspective :: proc(m: ^matrix_t, fovy: f32, aspect: f32, z_near: f32, z_far: f32) -> ^matrix_t ---
		matrix_init_rotate :: proc(m: ^matrix_t, angle: f32, axis: ^vec3_t) -> ^matrix_t ---
		matrix_init_scale :: proc(m: ^matrix_t, x: f32, y: f32, z: f32) -> ^matrix_t ---
		matrix_init_skew :: proc(m: ^matrix_t, x_skew: f32, y_skew: f32) -> ^matrix_t ---
		matrix_init_translate :: proc(m: ^matrix_t, p: ^point3d_t) -> ^matrix_t ---
		matrix_interpolate :: proc(a: ^matrix_t, b: ^matrix_t, factor: f64, res: ^matrix_t) ---
		matrix_inverse :: proc(m: ^matrix_t, res: ^matrix_t) -> b8 ---
		matrix_is_2d :: proc(m: ^matrix_t) -> b8 ---
		matrix_is_backface_visible :: proc(m: ^matrix_t) -> b8 ---
		matrix_is_identity :: proc(m: ^matrix_t) -> b8 ---
		matrix_is_singular :: proc(m: ^matrix_t) -> b8 ---
		matrix_multiply :: proc(a: ^matrix_t, b: ^matrix_t, res: ^matrix_t) ---
		matrix_near :: proc(a: ^matrix_t, b: ^matrix_t, epsilon: f32) -> b8 ---
		matrix_normalize :: proc(m: ^matrix_t, res: ^matrix_t) ---
		matrix_perspective :: proc(m: ^matrix_t, depth: f32, res: ^matrix_t) ---
		matrix_print :: proc(m: ^matrix_t) ---
		matrix_project_point :: proc(m: ^matrix_t, p: ^point_t, res: ^point_t) ---
		matrix_project_rect :: proc(m: ^matrix_t, r: ^rect_t, res: ^quad_t) ---
		matrix_project_rect_bounds :: proc(m: ^matrix_t, r: ^rect_t, res: ^rect_t) ---
		matrix_rotate :: proc(m: ^matrix_t, angle: f32, axis: ^vec3_t) ---
		matrix_rotate_euler :: proc(m: ^matrix_t, e: ^euler_t) ---
		matrix_rotate_quaternion :: proc(m: ^matrix_t, q: ^quaternion_t) ---
		matrix_rotate_x :: proc(m: ^matrix_t, angle: f32) ---
		matrix_rotate_y :: proc(m: ^matrix_t, angle: f32) ---
		matrix_rotate_z :: proc(m: ^matrix_t, angle: f32) ---
		matrix_scale :: proc(m: ^matrix_t, factor_x: f32, factor_y: f32, factor_z: f32) ---
		matrix_skew_xy :: proc(m: ^matrix_t, factor: f32) ---
		matrix_skew_xz :: proc(m: ^matrix_t, factor: f32) ---
		matrix_skew_yz :: proc(m: ^matrix_t, factor: f32) ---
		matrix_to_2d :: proc(m: ^matrix_t, xx: ^f64, yx: ^f64, xy: ^f64, yy: ^f64, x_0: ^f64, y_0: ^f64) -> b8 ---
		matrix_to_float :: proc(m: ^matrix_t, v: ^f32) ---
		matrix_transform_bounds :: proc(m: ^matrix_t, r: ^rect_t, res: ^rect_t) ---
		matrix_transform_box :: proc(m: ^matrix_t, b: ^box_t, res: ^box_t) ---
		matrix_transform_point :: proc(m: ^matrix_t, p: ^point_t, res: ^point_t) ---
		matrix_transform_point3d :: proc(m: ^matrix_t, p: ^point3d_t, res: ^point3d_t) ---
		matrix_transform_ray :: proc(m: ^matrix_t, r: ^ray_t, res: ^ray_t) ---
		matrix_transform_rect :: proc(m: ^matrix_t, r: ^rect_t, res: ^quad_t) ---
		matrix_transform_sphere :: proc(m: ^matrix_t, s: ^sphere_t, res: ^sphere_t) ---
		matrix_transform_vec3 :: proc(m: ^matrix_t, v: ^vec3_t, res: ^vec3_t) ---
		matrix_transform_vec4 :: proc(m: ^matrix_t, v: ^vec4_t, res: ^vec4_t) ---
		matrix_translate :: proc(m: ^matrix_t, pos: ^point3d_t) ---
		matrix_transpose :: proc(m: ^matrix_t, res: ^matrix_t) ---
		matrix_unproject_point3d :: proc(projection: ^matrix_t, modelview: ^matrix_t, point: ^point3d_t, res: ^point3d_t) ---
		matrix_untransform_bounds :: proc(m: ^matrix_t, r: ^rect_t, bounds: ^rect_t, res: ^rect_t) ---
		matrix_untransform_point :: proc(m: ^matrix_t, p: ^point_t, bounds: ^rect_t, res: ^point_t) -> b8 ---
		plane_alloc :: proc() -> ^plane_t ---
		plane_distance :: proc(p: ^plane_t, point: ^point3d_t) -> f32 ---
		plane_equal :: proc(a: ^plane_t, b: ^plane_t) -> b8 ---
		plane_free :: proc(p: ^plane_t) ---
		plane_get_constant :: proc(p: ^plane_t) -> f32 ---
		plane_get_normal :: proc(p: ^plane_t, normal: ^vec3_t) ---
		plane_get_type :: proc() -> gobj.Type ---
		plane_get_type :: proc() -> gobj.Type ---
		plane_init :: proc(p: ^plane_t, normal: ^vec3_t, constant: f32) -> ^plane_t ---
		plane_init_from_plane :: proc(p: ^plane_t, src: ^plane_t) -> ^plane_t ---
		plane_init_from_point :: proc(p: ^plane_t, normal: ^vec3_t, point: ^point3d_t) -> ^plane_t ---
		plane_init_from_points :: proc(p: ^plane_t, a: ^point3d_t, b: ^point3d_t, c: ^point3d_t) -> ^plane_t ---
		plane_init_from_vec4 :: proc(p: ^plane_t, src: ^vec4_t) -> ^plane_t ---
		plane_negate :: proc(p: ^plane_t, res: ^plane_t) ---
		plane_normalize :: proc(p: ^plane_t, res: ^plane_t) ---
		plane_transform :: proc(p: ^plane_t, matrix_p: ^matrix_t, normal_matrix: ^matrix_t, res: ^plane_t) ---
		point3d_alloc :: proc() -> ^point3d_t ---
		point3d_cross :: proc(a: ^point3d_t, b: ^point3d_t, res: ^point3d_t) ---
		point3d_distance :: proc(a: ^point3d_t, b: ^point3d_t, delta: ^vec3_t) -> f32 ---
		point3d_dot :: proc(a: ^point3d_t, b: ^point3d_t) -> f32 ---
		point3d_equal :: proc(a: ^point3d_t, b: ^point3d_t) -> b8 ---
		point3d_free :: proc(p: ^point3d_t) ---
		point3d_get_type :: proc() -> gobj.Type ---
		point3d_get_type :: proc() -> gobj.Type ---
		point3d_init :: proc(p: ^point3d_t, x: f32, y: f32, z: f32) -> ^point3d_t ---
		point3d_init_from_point :: proc(p: ^point3d_t, src: ^point3d_t) -> ^point3d_t ---
		point3d_init_from_vec3 :: proc(p: ^point3d_t, v: ^vec3_t) -> ^point3d_t ---
		point3d_interpolate :: proc(a: ^point3d_t, b: ^point3d_t, factor: f64, res: ^point3d_t) ---
		point3d_length :: proc(p: ^point3d_t) -> f32 ---
		point3d_near :: proc(a: ^point3d_t, b: ^point3d_t, epsilon: f32) -> b8 ---
		point3d_normalize :: proc(p: ^point3d_t, res: ^point3d_t) ---
		point3d_normalize_viewport :: proc(p: ^point3d_t, viewport: ^rect_t, z_near: f32, z_far: f32, res: ^point3d_t) ---
		point3d_scale :: proc(p: ^point3d_t, factor: f32, res: ^point3d_t) ---
		point3d_to_vec3 :: proc(p: ^point3d_t, v: ^vec3_t) ---
		point3d_zero :: proc() -> ^point3d_t ---
		point_alloc :: proc() -> ^point_t ---
		point_distance :: proc(a: ^point_t, b: ^point_t, d_x: ^f32, d_y: ^f32) -> f32 ---
		point_equal :: proc(a: ^point_t, b: ^point_t) -> b8 ---
		point_free :: proc(p: ^point_t) ---
		point_get_type :: proc() -> gobj.Type ---
		point_get_type :: proc() -> gobj.Type ---
		point_init :: proc(p: ^point_t, x: f32, y: f32) -> ^point_t ---
		point_init_from_point :: proc(p: ^point_t, src: ^point_t) -> ^point_t ---
		point_init_from_vec2 :: proc(p: ^point_t, src: ^vec2_t) -> ^point_t ---
		point_interpolate :: proc(a: ^point_t, b: ^point_t, factor: f64, res: ^point_t) ---
		point_near :: proc(a: ^point_t, b: ^point_t, epsilon: f32) -> b8 ---
		point_to_vec2 :: proc(p: ^point_t, v: ^vec2_t) ---
		point_zero :: proc() -> ^point_t ---
		quad_alloc :: proc() -> ^quad_t ---
		quad_bounds :: proc(q: ^quad_t, r: ^rect_t) ---
		quad_contains :: proc(q: ^quad_t, p: ^point_t) -> b8 ---
		quad_free :: proc(q: ^quad_t) ---
		quad_get_point :: proc(q: ^quad_t, index_: u32) -> ^point_t ---
		quad_get_type :: proc() -> gobj.Type ---
		quad_get_type :: proc() -> gobj.Type ---
		quad_init :: proc(q: ^quad_t, p1: ^point_t, p2: ^point_t, p3: ^point_t, p4: ^point_t) -> ^quad_t ---
		quad_init_from_points :: proc(q: ^quad_t, points: [^]point_t) -> ^quad_t ---
		quad_init_from_rect :: proc(q: ^quad_t, r: ^rect_t) -> ^quad_t ---
		quaternion_add :: proc(a: ^quaternion_t, b: ^quaternion_t, res: ^quaternion_t) ---
		quaternion_alloc :: proc() -> ^quaternion_t ---
		quaternion_dot :: proc(a: ^quaternion_t, b: ^quaternion_t) -> f32 ---
		quaternion_equal :: proc(a: ^quaternion_t, b: ^quaternion_t) -> b8 ---
		quaternion_free :: proc(q: ^quaternion_t) ---
		quaternion_get_type :: proc() -> gobj.Type ---
		quaternion_get_type :: proc() -> gobj.Type ---
		quaternion_init :: proc(q: ^quaternion_t, x: f32, y: f32, z: f32, w: f32) -> ^quaternion_t ---
		quaternion_init_from_angle_vec3 :: proc(q: ^quaternion_t, angle: f32, axis: ^vec3_t) -> ^quaternion_t ---
		quaternion_init_from_angles :: proc(q: ^quaternion_t, deg_x: f32, deg_y: f32, deg_z: f32) -> ^quaternion_t ---
		quaternion_init_from_euler :: proc(q: ^quaternion_t, e: ^euler_t) -> ^quaternion_t ---
		quaternion_init_from_matrix :: proc(q: ^quaternion_t, m: ^matrix_t) -> ^quaternion_t ---
		quaternion_init_from_quaternion :: proc(q: ^quaternion_t, src: ^quaternion_t) -> ^quaternion_t ---
		quaternion_init_from_radians :: proc(q: ^quaternion_t, rad_x: f32, rad_y: f32, rad_z: f32) -> ^quaternion_t ---
		quaternion_init_from_vec4 :: proc(q: ^quaternion_t, src: ^vec4_t) -> ^quaternion_t ---
		quaternion_init_identity :: proc(q: ^quaternion_t) -> ^quaternion_t ---
		quaternion_invert :: proc(q: ^quaternion_t, res: ^quaternion_t) ---
		quaternion_multiply :: proc(a: ^quaternion_t, b: ^quaternion_t, res: ^quaternion_t) ---
		quaternion_normalize :: proc(q: ^quaternion_t, res: ^quaternion_t) ---
		quaternion_scale :: proc(q: ^quaternion_t, factor: f32, res: ^quaternion_t) ---
		quaternion_slerp :: proc(a: ^quaternion_t, b: ^quaternion_t, factor: f32, res: ^quaternion_t) ---
		quaternion_to_angle_vec3 :: proc(q: ^quaternion_t, angle: ^f32, axis: ^vec3_t) ---
		quaternion_to_angles :: proc(q: ^quaternion_t, deg_x: ^f32, deg_y: ^f32, deg_z: ^f32) ---
		quaternion_to_matrix :: proc(q: ^quaternion_t, m: ^matrix_t) ---
		quaternion_to_radians :: proc(q: ^quaternion_t, rad_x: ^f32, rad_y: ^f32, rad_z: ^f32) ---
		quaternion_to_vec4 :: proc(q: ^quaternion_t, res: ^vec4_t) ---
		ray_alloc :: proc() -> ^ray_t ---
		ray_equal :: proc(a: ^ray_t, b: ^ray_t) -> b8 ---
		ray_free :: proc(r: ^ray_t) ---
		ray_get_closest_point_to_point :: proc(r: ^ray_t, p: ^point3d_t, res: ^point3d_t) ---
		ray_get_direction :: proc(r: ^ray_t, direction: ^vec3_t) ---
		ray_get_distance_to_plane :: proc(r: ^ray_t, p: ^plane_t) -> f32 ---
		ray_get_distance_to_point :: proc(r: ^ray_t, p: ^point3d_t) -> f32 ---
		ray_get_origin :: proc(r: ^ray_t, origin: ^point3d_t) ---
		ray_get_position_at :: proc(r: ^ray_t, t: f32, position: ^point3d_t) ---
		ray_get_type :: proc() -> gobj.Type ---
		ray_get_type :: proc() -> gobj.Type ---
		ray_init :: proc(r: ^ray_t, origin: ^point3d_t, direction: ^vec3_t) -> ^ray_t ---
		ray_init_from_ray :: proc(r: ^ray_t, src: ^ray_t) -> ^ray_t ---
		ray_init_from_vec3 :: proc(r: ^ray_t, origin: ^vec3_t, direction: ^vec3_t) -> ^ray_t ---
		ray_intersect_box :: proc(r: ^ray_t, b: ^box_t, t_out: ^f32) -> ray_intersection_kind_t ---
		ray_intersect_sphere :: proc(r: ^ray_t, s: ^sphere_t, t_out: ^f32) -> ray_intersection_kind_t ---
		ray_intersect_triangle :: proc(r: ^ray_t, t: ^triangle_t, t_out: ^f32) -> ray_intersection_kind_t ---
		ray_intersects_box :: proc(r: ^ray_t, b: ^box_t) -> b8 ---
		ray_intersects_sphere :: proc(r: ^ray_t, s: ^sphere_t) -> b8 ---
		ray_intersects_triangle :: proc(r: ^ray_t, t: ^triangle_t) -> b8 ---
		rect_alloc :: proc() -> ^rect_t ---
		rect_contains_point :: proc(r: ^rect_t, p: ^point_t) -> b8 ---
		rect_contains_rect :: proc(a: ^rect_t, b: ^rect_t) -> b8 ---
		rect_equal :: proc(a: ^rect_t, b: ^rect_t) -> b8 ---
		rect_expand :: proc(r: ^rect_t, p: ^point_t, res: ^rect_t) ---
		rect_free :: proc(r: ^rect_t) ---
		rect_get_area :: proc(r: ^rect_t) -> f32 ---
		rect_get_bottom_left :: proc(r: ^rect_t, p: ^point_t) ---
		rect_get_bottom_right :: proc(r: ^rect_t, p: ^point_t) ---
		rect_get_center :: proc(r: ^rect_t, p: ^point_t) ---
		rect_get_height :: proc(r: ^rect_t) -> f32 ---
		rect_get_top_left :: proc(r: ^rect_t, p: ^point_t) ---
		rect_get_top_right :: proc(r: ^rect_t, p: ^point_t) ---
		rect_get_type :: proc() -> gobj.Type ---
		rect_get_type :: proc() -> gobj.Type ---
		rect_get_vertices :: proc(r: ^rect_t, vertices: [^]vec2_t) ---
		rect_get_width :: proc(r: ^rect_t) -> f32 ---
		rect_get_x :: proc(r: ^rect_t) -> f32 ---
		rect_get_y :: proc(r: ^rect_t) -> f32 ---
		rect_init :: proc(r: ^rect_t, x: f32, y: f32, width: f32, height: f32) -> ^rect_t ---
		rect_init_from_rect :: proc(r: ^rect_t, src: ^rect_t) -> ^rect_t ---
		rect_inset :: proc(r: ^rect_t, d_x: f32, d_y: f32) -> ^rect_t ---
		rect_inset_r :: proc(r: ^rect_t, d_x: f32, d_y: f32, res: ^rect_t) ---
		rect_interpolate :: proc(a: ^rect_t, b: ^rect_t, factor: f64, res: ^rect_t) ---
		rect_intersection :: proc(a: ^rect_t, b: ^rect_t, res: ^rect_t) -> b8 ---
		rect_normalize :: proc(r: ^rect_t) -> ^rect_t ---
		rect_normalize_r :: proc(r: ^rect_t, res: ^rect_t) ---
		rect_offset :: proc(r: ^rect_t, d_x: f32, d_y: f32) -> ^rect_t ---
		rect_offset_r :: proc(r: ^rect_t, d_x: f32, d_y: f32, res: ^rect_t) ---
		rect_round :: proc(r: ^rect_t, res: ^rect_t) ---
		rect_round_extents :: proc(r: ^rect_t, res: ^rect_t) ---
		rect_round_to_pixel :: proc(r: ^rect_t) -> ^rect_t ---
		rect_scale :: proc(r: ^rect_t, s_h: f32, s_v: f32, res: ^rect_t) ---
		rect_union :: proc(a: ^rect_t, b: ^rect_t, res: ^rect_t) ---
		rect_zero :: proc() -> ^rect_t ---
		simd4f_add :: proc(a: simd4f_t, b: simd4f_t) -> simd4f_t ---
		simd4f_cmp_eq :: proc(a: simd4f_t, b: simd4f_t) -> b8 ---
		simd4f_cmp_ge :: proc(a: simd4f_t, b: simd4f_t) -> b8 ---
		simd4f_cmp_gt :: proc(a: simd4f_t, b: simd4f_t) -> b8 ---
		simd4f_cmp_le :: proc(a: simd4f_t, b: simd4f_t) -> b8 ---
		simd4f_cmp_lt :: proc(a: simd4f_t, b: simd4f_t) -> b8 ---
		simd4f_cmp_neq :: proc(a: simd4f_t, b: simd4f_t) -> b8 ---
		simd4f_cross3 :: proc(a: simd4f_t, b: simd4f_t) -> simd4f_t ---
		simd4f_div :: proc(a: simd4f_t, b: simd4f_t) -> simd4f_t ---
		simd4f_dot3 :: proc(a: simd4f_t, b: simd4f_t) -> simd4f_t ---
		simd4f_dot3_scalar :: proc(a: simd4f_t, b: simd4f_t) -> f32 ---
		simd4f_dup_2f :: proc(s: simd4f_t, v: ^f32) ---
		simd4f_dup_3f :: proc(s: simd4f_t, v: ^f32) ---
		simd4f_dup_4f :: proc(s: simd4f_t, v: ^f32) ---
		simd4f_flip_sign_0101 :: proc(s: simd4f_t) -> simd4f_t ---
		simd4f_flip_sign_1010 :: proc(s: simd4f_t) -> simd4f_t ---
		simd4f_get :: proc(s: simd4f_t, i: u32) -> f32 ---
		simd4f_get_w :: proc(s: simd4f_t) -> f32 ---
		simd4f_get_x :: proc(s: simd4f_t) -> f32 ---
		simd4f_get_y :: proc(s: simd4f_t) -> f32 ---
		simd4f_get_z :: proc(s: simd4f_t) -> f32 ---
		simd4f_init :: proc(x: f32, y: f32, z: f32, w: f32) -> simd4f_t ---
		simd4f_init_2f :: proc(v: ^f32) -> simd4f_t ---
		simd4f_init_3f :: proc(v: ^f32) -> simd4f_t ---
		simd4f_init_4f :: proc(v: ^f32) -> simd4f_t ---
		simd4f_init_zero :: proc() -> simd4f_t ---
		simd4f_max :: proc(a: simd4f_t, b: simd4f_t) -> simd4f_t ---
		simd4f_merge_high :: proc(a: simd4f_t, b: simd4f_t) -> simd4f_t ---
		simd4f_merge_low :: proc(a: simd4f_t, b: simd4f_t) -> simd4f_t ---
		simd4f_merge_w :: proc(s: simd4f_t, v: f32) -> simd4f_t ---
		simd4f_min :: proc(a: simd4f_t, b: simd4f_t) -> simd4f_t ---
		simd4f_mul :: proc(a: simd4f_t, b: simd4f_t) -> simd4f_t ---
		simd4f_neg :: proc(s: simd4f_t) -> simd4f_t ---
		simd4f_reciprocal :: proc(s: simd4f_t) -> simd4f_t ---
		simd4f_rsqrt :: proc(s: simd4f_t) -> simd4f_t ---
		simd4f_shuffle_wxyz :: proc(s: simd4f_t) -> simd4f_t ---
		simd4f_shuffle_yzwx :: proc(s: simd4f_t) -> simd4f_t ---
		simd4f_shuffle_zwxy :: proc(s: simd4f_t) -> simd4f_t ---
		simd4f_splat :: proc(v: f32) -> simd4f_t ---
		simd4f_splat_w :: proc(s: simd4f_t) -> simd4f_t ---
		simd4f_splat_x :: proc(s: simd4f_t) -> simd4f_t ---
		simd4f_splat_y :: proc(s: simd4f_t) -> simd4f_t ---
		simd4f_splat_z :: proc(s: simd4f_t) -> simd4f_t ---
		simd4f_sqrt :: proc(s: simd4f_t) -> simd4f_t ---
		simd4f_sub :: proc(a: simd4f_t, b: simd4f_t) -> simd4f_t ---
		simd4f_zero_w :: proc(s: simd4f_t) -> simd4f_t ---
		simd4f_zero_zw :: proc(s: simd4f_t) -> simd4f_t ---
		simd4x4f_transpose_in_place :: proc(s: ^simd4x4f_t) ---
		size_alloc :: proc() -> ^size_t ---
		size_equal :: proc(a: ^size_t, b: ^size_t) -> b8 ---
		size_free :: proc(s: ^size_t) ---
		size_get_type :: proc() -> gobj.Type ---
		size_get_type :: proc() -> gobj.Type ---
		size_init :: proc(s: ^size_t, width: f32, height: f32) -> ^size_t ---
		size_init_from_size :: proc(s: ^size_t, src: ^size_t) -> ^size_t ---
		size_interpolate :: proc(a: ^size_t, b: ^size_t, factor: f64, res: ^size_t) ---
		size_scale :: proc(s: ^size_t, factor: f32, res: ^size_t) ---
		size_zero :: proc() -> ^size_t ---
		sphere_alloc :: proc() -> ^sphere_t ---
		sphere_contains_point :: proc(s: ^sphere_t, point: ^point3d_t) -> b8 ---
		sphere_distance :: proc(s: ^sphere_t, point: ^point3d_t) -> f32 ---
		sphere_equal :: proc(a: ^sphere_t, b: ^sphere_t) -> b8 ---
		sphere_free :: proc(s: ^sphere_t) ---
		sphere_get_bounding_box :: proc(s: ^sphere_t, box: ^box_t) ---
		sphere_get_center :: proc(s: ^sphere_t, center: ^point3d_t) ---
		sphere_get_radius :: proc(s: ^sphere_t) -> f32 ---
		sphere_get_type :: proc() -> gobj.Type ---
		sphere_get_type :: proc() -> gobj.Type ---
		sphere_init :: proc(s: ^sphere_t, center: ^point3d_t, radius: f32) -> ^sphere_t ---
		sphere_init_from_points :: proc(s: ^sphere_t, n_points: u32, points: [^]point3d_t, center: ^point3d_t) -> ^sphere_t ---
		sphere_init_from_vectors :: proc(s: ^sphere_t, n_vectors: u32, vectors: [^]vec3_t, center: ^point3d_t) -> ^sphere_t ---
		sphere_is_empty :: proc(s: ^sphere_t) -> b8 ---
		sphere_translate :: proc(s: ^sphere_t, point: ^point3d_t, res: ^sphere_t) ---
		triangle_alloc :: proc() -> ^triangle_t ---
		triangle_contains_point :: proc(t: ^triangle_t, p: ^point3d_t) -> b8 ---
		triangle_equal :: proc(a: ^triangle_t, b: ^triangle_t) -> b8 ---
		triangle_free :: proc(t: ^triangle_t) ---
		triangle_get_area :: proc(t: ^triangle_t) -> f32 ---
		triangle_get_barycoords :: proc(t: ^triangle_t, p: ^point3d_t, res: ^vec2_t) -> b8 ---
		triangle_get_bounding_box :: proc(t: ^triangle_t, res: ^box_t) ---
		triangle_get_midpoint :: proc(t: ^triangle_t, res: ^point3d_t) ---
		triangle_get_normal :: proc(t: ^triangle_t, res: ^vec3_t) ---
		triangle_get_plane :: proc(t: ^triangle_t, res: ^plane_t) ---
		triangle_get_points :: proc(t: ^triangle_t, a: ^point3d_t, b: ^point3d_t, c: ^point3d_t) ---
		triangle_get_type :: proc() -> gobj.Type ---
		triangle_get_type :: proc() -> gobj.Type ---
		triangle_get_uv :: proc(t: ^triangle_t, p: ^point3d_t, uv_a: ^vec2_t, uv_b: ^vec2_t, uv_c: ^vec2_t, res: ^vec2_t) -> b8 ---
		triangle_get_vertices :: proc(t: ^triangle_t, a: ^vec3_t, b: ^vec3_t, c: ^vec3_t) ---
		triangle_init_from_float :: proc(t: ^triangle_t, a: ^f32, b: ^f32, c: ^f32) -> ^triangle_t ---
		triangle_init_from_point3d :: proc(t: ^triangle_t, a: ^point3d_t, b: ^point3d_t, c: ^point3d_t) -> ^triangle_t ---
		triangle_init_from_vec3 :: proc(t: ^triangle_t, a: ^vec3_t, b: ^vec3_t, c: ^vec3_t) -> ^triangle_t ---
		vec2_add :: proc(a: ^vec2_t, b: ^vec2_t, res: ^vec2_t) ---
		vec2_alloc :: proc() -> ^vec2_t ---
		vec2_divide :: proc(a: ^vec2_t, b: ^vec2_t, res: ^vec2_t) ---
		vec2_dot :: proc(a: ^vec2_t, b: ^vec2_t) -> f32 ---
		vec2_equal :: proc(v1: ^vec2_t, v2: ^vec2_t) -> b8 ---
		vec2_free :: proc(v: ^vec2_t) ---
		vec2_get_type :: proc() -> gobj.Type ---
		vec2_get_type :: proc() -> gobj.Type ---
		vec2_get_x :: proc(v: ^vec2_t) -> f32 ---
		vec2_get_y :: proc(v: ^vec2_t) -> f32 ---
		vec2_init :: proc(v: ^vec2_t, x: f32, y: f32) -> ^vec2_t ---
		vec2_init_from_float :: proc(v: ^vec2_t, src: ^f32) -> ^vec2_t ---
		vec2_init_from_vec2 :: proc(v: ^vec2_t, src: ^vec2_t) -> ^vec2_t ---
		vec2_interpolate :: proc(v1: ^vec2_t, v2: ^vec2_t, factor: f64, res: ^vec2_t) ---
		vec2_length :: proc(v: ^vec2_t) -> f32 ---
		vec2_max :: proc(a: ^vec2_t, b: ^vec2_t, res: ^vec2_t) ---
		vec2_min :: proc(a: ^vec2_t, b: ^vec2_t, res: ^vec2_t) ---
		vec2_multiply :: proc(a: ^vec2_t, b: ^vec2_t, res: ^vec2_t) ---
		vec2_near :: proc(v1: ^vec2_t, v2: ^vec2_t, epsilon: f32) -> b8 ---
		vec2_negate :: proc(v: ^vec2_t, res: ^vec2_t) ---
		vec2_normalize :: proc(v: ^vec2_t, res: ^vec2_t) ---
		vec2_one :: proc() -> ^vec2_t ---
		vec2_scale :: proc(v: ^vec2_t, factor: f32, res: ^vec2_t) ---
		vec2_subtract :: proc(a: ^vec2_t, b: ^vec2_t, res: ^vec2_t) ---
		vec2_to_float :: proc(v: ^vec2_t, dest: ^f32) ---
		vec2_x_axis :: proc() -> ^vec2_t ---
		vec2_y_axis :: proc() -> ^vec2_t ---
		vec2_zero :: proc() -> ^vec2_t ---
		vec3_add :: proc(a: ^vec3_t, b: ^vec3_t, res: ^vec3_t) ---
		vec3_alloc :: proc() -> ^vec3_t ---
		vec3_cross :: proc(a: ^vec3_t, b: ^vec3_t, res: ^vec3_t) ---
		vec3_divide :: proc(a: ^vec3_t, b: ^vec3_t, res: ^vec3_t) ---
		vec3_dot :: proc(a: ^vec3_t, b: ^vec3_t) -> f32 ---
		vec3_equal :: proc(v1: ^vec3_t, v2: ^vec3_t) -> b8 ---
		vec3_free :: proc(v: ^vec3_t) ---
		vec3_get_type :: proc() -> gobj.Type ---
		vec3_get_type :: proc() -> gobj.Type ---
		vec3_get_x :: proc(v: ^vec3_t) -> f32 ---
		vec3_get_xy :: proc(v: ^vec3_t, res: ^vec2_t) ---
		vec3_get_xy0 :: proc(v: ^vec3_t, res: ^vec3_t) ---
		vec3_get_xyz0 :: proc(v: ^vec3_t, res: ^vec4_t) ---
		vec3_get_xyz1 :: proc(v: ^vec3_t, res: ^vec4_t) ---
		vec3_get_xyzw :: proc(v: ^vec3_t, w: f32, res: ^vec4_t) ---
		vec3_get_y :: proc(v: ^vec3_t) -> f32 ---
		vec3_get_z :: proc(v: ^vec3_t) -> f32 ---
		vec3_init :: proc(v: ^vec3_t, x: f32, y: f32, z: f32) -> ^vec3_t ---
		vec3_init_from_float :: proc(v: ^vec3_t, src: ^f32) -> ^vec3_t ---
		vec3_init_from_vec3 :: proc(v: ^vec3_t, src: ^vec3_t) -> ^vec3_t ---
		vec3_interpolate :: proc(v1: ^vec3_t, v2: ^vec3_t, factor: f64, res: ^vec3_t) ---
		vec3_length :: proc(v: ^vec3_t) -> f32 ---
		vec3_max :: proc(a: ^vec3_t, b: ^vec3_t, res: ^vec3_t) ---
		vec3_min :: proc(a: ^vec3_t, b: ^vec3_t, res: ^vec3_t) ---
		vec3_multiply :: proc(a: ^vec3_t, b: ^vec3_t, res: ^vec3_t) ---
		vec3_near :: proc(v1: ^vec3_t, v2: ^vec3_t, epsilon: f32) -> b8 ---
		vec3_negate :: proc(v: ^vec3_t, res: ^vec3_t) ---
		vec3_normalize :: proc(v: ^vec3_t, res: ^vec3_t) ---
		vec3_one :: proc() -> ^vec3_t ---
		vec3_scale :: proc(v: ^vec3_t, factor: f32, res: ^vec3_t) ---
		vec3_subtract :: proc(a: ^vec3_t, b: ^vec3_t, res: ^vec3_t) ---
		vec3_to_float :: proc(v: ^vec3_t, dest: ^f32) ---
		vec3_x_axis :: proc() -> ^vec3_t ---
		vec3_y_axis :: proc() -> ^vec3_t ---
		vec3_z_axis :: proc() -> ^vec3_t ---
		vec3_zero :: proc() -> ^vec3_t ---
		vec4_add :: proc(a: ^vec4_t, b: ^vec4_t, res: ^vec4_t) ---
		vec4_alloc :: proc() -> ^vec4_t ---
		vec4_divide :: proc(a: ^vec4_t, b: ^vec4_t, res: ^vec4_t) ---
		vec4_dot :: proc(a: ^vec4_t, b: ^vec4_t) -> f32 ---
		vec4_equal :: proc(v1: ^vec4_t, v2: ^vec4_t) -> b8 ---
		vec4_free :: proc(v: ^vec4_t) ---
		vec4_get_type :: proc() -> gobj.Type ---
		vec4_get_type :: proc() -> gobj.Type ---
		vec4_get_w :: proc(v: ^vec4_t) -> f32 ---
		vec4_get_x :: proc(v: ^vec4_t) -> f32 ---
		vec4_get_xy :: proc(v: ^vec4_t, res: ^vec2_t) ---
		vec4_get_xyz :: proc(v: ^vec4_t, res: ^vec3_t) ---
		vec4_get_y :: proc(v: ^vec4_t) -> f32 ---
		vec4_get_z :: proc(v: ^vec4_t) -> f32 ---
		vec4_init :: proc(v: ^vec4_t, x: f32, y: f32, z: f32, w: f32) -> ^vec4_t ---
		vec4_init_from_float :: proc(v: ^vec4_t, src: ^f32) -> ^vec4_t ---
		vec4_init_from_vec2 :: proc(v: ^vec4_t, src: ^vec2_t, z: f32, w: f32) -> ^vec4_t ---
		vec4_init_from_vec3 :: proc(v: ^vec4_t, src: ^vec3_t, w: f32) -> ^vec4_t ---
		vec4_init_from_vec4 :: proc(v: ^vec4_t, src: ^vec4_t) -> ^vec4_t ---
		vec4_interpolate :: proc(v1: ^vec4_t, v2: ^vec4_t, factor: f64, res: ^vec4_t) ---
		vec4_length :: proc(v: ^vec4_t) -> f32 ---
		vec4_max :: proc(a: ^vec4_t, b: ^vec4_t, res: ^vec4_t) ---
		vec4_min :: proc(a: ^vec4_t, b: ^vec4_t, res: ^vec4_t) ---
		vec4_multiply :: proc(a: ^vec4_t, b: ^vec4_t, res: ^vec4_t) ---
		vec4_near :: proc(v1: ^vec4_t, v2: ^vec4_t, epsilon: f32) -> b8 ---
		vec4_negate :: proc(v: ^vec4_t, res: ^vec4_t) ---
		vec4_normalize :: proc(v: ^vec4_t, res: ^vec4_t) ---
		vec4_one :: proc() -> ^vec4_t ---
		vec4_scale :: proc(v: ^vec4_t, factor: f32, res: ^vec4_t) ---
		vec4_subtract :: proc(a: ^vec4_t, b: ^vec4_t, res: ^vec4_t) ---
		vec4_to_float :: proc(v: ^vec4_t, dest: ^f32) ---
		vec4_w_axis :: proc() -> ^vec4_t ---
		vec4_x_axis :: proc() -> ^vec4_t ---
		vec4_y_axis :: proc() -> ^vec4_t ---
		vec4_z_axis :: proc() -> ^vec4_t ---
		vec4_zero :: proc() -> ^vec4_t ---

	types
		box_t :: struct {__graphene_private_min: vec3_t, __graphene_private_max: vec3_t}
		euler_order_t :: enum i32 {DEFAULT = -1, XYZ = 0, YZX = 1, ZXY = 2, XZY = 3, YXZ = 4, ZYX = 5, SXYZ = 6, SXYX = 7, SXZY = 8, SXZX = 9, SYZX = 10, SYZY = 11, SYXZ = 12, SYXY = 13, SZXY = 14, SZXZ = 15, SZYX = 16, SZYZ = 17, RZYX = 18, RXYX = 19, RYZX = 20, RXZX = 21, RXZY = 22, RYZY = 23, RZXY = 24, RYXY = 25, RYXZ = 26, RZXZ = 27, RXYZ = 28, RZYZ = 29}
		euler_t :: struct {__graphene_private_angles: vec3_t, __graphene_private_order: euler_order_t}
		frustum_t :: struct {__graphene_private_planes: [6]plane_t}
		matrix_t :: struct {__graphene_private_value: simd4x4f_t}
		plane_t :: struct {__graphene_private_normal: vec3_t, __graphene_private_constant: f32}
		point3d_t :: struct {x: f32, y: f32, z: f32}
		point_t :: struct {x: f32, y: f32}
		quad_t :: struct {__graphene_private_points: [4]point_t}
		quaternion_t :: struct {__graphene_private_x: f32, __graphene_private_y: f32, __graphene_private_z: f32, __graphene_private_w: f32}
		ray_intersection_kind_t :: enum u32 {NONE = 0, ENTER = 1, LEAVE = 2}
		ray_t :: struct {__graphene_private_origin: vec3_t, __graphene_private_direction: vec3_t}
		rect_t :: struct {origin: point_t, size: size_t}
		simd4f_t :: #simd[4]f32
		simd4x4f_t :: struct {x: simd4f_t, y: simd4f_t, z: simd4f_t, w: simd4f_t}
		size_t :: struct {width: f32, height: f32}
		sphere_t :: struct {__graphene_private_center: vec3_t, __graphene_private_radius: f32}
		triangle_t :: struct {__graphene_private_a: vec3_t, __graphene_private_b: vec3_t, __graphene_private_c: vec3_t}
		vec2_t :: struct {__graphene_private_value: simd4f_t}
		vec3_t :: struct {__graphene_private_value: simd4f_t}
		vec4_t :: struct {__graphene_private_value: simd4f_t}

	files:
		graphene.odin
		patched.odin
```
