class_name RangeArea
extends Area3D

@export var radius: float = 2.0:
	set(value):
		radius = value
		_update_shape()
@export var height_offset: float = 0.0
@export var cone_angle: float = 360.0
@export var collision_mask_override: int = 1 << 0

@export var debug_draw_enabled: bool = true
@export var debug_draw_color: Color = Color(1.0, 0.0, 0.0, 0.35)
@export var debug_draw_segments: int = 32

var _self_id: int = -1 # instance_id to exclude; -1 (default) excludes no one
var _sphere: SphereShape3D

func _init(
	p_radius: float = 2.0,
	p_height_offset: float = 0.0,
	p_cone_angle: float = 360.0,
	p_self_id: int = -1
) -> void:
	radius = p_radius
	height_offset = p_height_offset
	cone_angle = p_cone_angle
	_self_id = p_self_id

func _ready() -> void:
	monitoring = true
	monitorable = false
	collision_mask = collision_mask_override
	position.y = height_offset

	_sphere = SphereShape3D.new()
	_sphere.radius = radius
	var shape := CollisionShape3D.new()
	shape.shape = _sphere
	add_child(shape)

	set_process(debug_draw_enabled)

func _process(_delta: float) -> void:
	_debug_draw()

func get_entities_in_range(forward: Vector3 = Vector3.ZERO) -> Array[Entity]:
	var results: Array[Entity] = []
	for body in get_overlapping_bodies():
		if not body is Entity:
			continue
		if _is_excluded(body, forward):
			continue
		results.append(body)
	return results

func get_bodies_in_range(forward: Vector3 = Vector3.ZERO) -> Array[Node3D]:
	var results: Array[Node3D] = []
	for body in get_overlapping_bodies():
		if _is_excluded(body, forward):
			continue
		results.append(body)
	return results

func is_position_in_range(target_pos: Vector3) -> bool:
	return global_position.distance_to(target_pos) <= radius

func get_random_location() -> Vector3:
	var dir := Vector3(randf_range(-1, 1), randf_range(-1, 1), randf_range(-1, 1)).normalized()
	return global_position + dir * randf_range(0.0, radius)

func _update_shape() -> void:
	if _sphere:
		_sphere.radius = radius

func _is_excluded(body: Node3D, forward: Vector3) -> bool:
	if _self_id != -1 and body.get_instance_id() == _self_id:
		return true
	if cone_angle < 360.0 and not _in_cone(global_position, body.global_position, forward):
		return true
	return false

func _in_cone(origin: Vector3, target_pos: Vector3, forward: Vector3) -> bool:
	if forward == Vector3.ZERO:
		return true
	var to_target := target_pos - origin
	to_target.y = 0.0
	if to_target.length() < 0.001:
		return true
	to_target = to_target.normalized()
	var fwd := forward
	fwd.y = 0.0
	fwd = fwd.normalized()
	return fwd.dot(to_target) >= cos(deg_to_rad(cone_angle / 2.0))

func _debug_draw(color: Color = debug_draw_color, duration: float = 0.0, segments: int = debug_draw_segments) -> void:
	var segment_count = max(3, segments)
	var points := PackedVector3Array()
	points.resize(segment_count + 1)
	for index in range(segment_count + 1):
		var angle := deg_to_rad(index * 360.0 / segment_count)
		points[index] = global_position + Vector3(cos(angle) * radius, 0.0, sin(angle) * radius)

	if ClassDB.class_exists("DebugDraw3D"):
		DebugDraw3D.draw_line_path(points, color, duration)
		DebugDraw3D.draw_line(points[0], points[segment_count], color, duration)