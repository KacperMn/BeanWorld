class_name RangeQuery extends Resource

@export var radius: float = 2.0
@export var cone_angle: float = 360.0 # 360 = full sphere
@export var height_offset: float = 0.0 # vertical center offset
@export var collision_mask: int = 1
@export var debug_draw_enabled: bool = true
@export var debug_draw_color: Color = Color(1.0, 0.0, 0.0, 0.35)
@export var debug_draw_duration: float = 0.0
@export var debug_draw_segments: int = 32

func _init(_radius: float = 0.0) -> void:
	if _radius > 0.0:
		self.radius = _radius

func get_entities_in_range(origin: Node3D, forward: Vector3 = Vector3.ZERO) -> Array[Entity]:
	var results: Array[Entity] = []
	var space := origin.get_world_3d().direct_space_state
	var center := origin.global_position + Vector3(0, height_offset, 0)

	var params := PhysicsShapeQueryParameters3D.new()
	var shape := SphereShape3D.new()
	shape.radius = radius
	params.shape = shape
	params.transform = Transform3D(Basis(), center)
	params.collision_mask = collision_mask
	params.exclude = [origin.get_rid()]

	var hits := space.intersect_shape(params)

	for hit in hits:
		var body = hit.collider
		if not body is Entity:
			continue
		if cone_angle < 360.0:
			if not _in_cone(center, body.global_position, forward):
				continue
		results.append(body)

	_draw_debug_if_enabled(origin)
	return results

func get_bodies_in_range(origin: Node3D) -> Array:
	var results := []
	var space := origin.get_world_3d().direct_space_state
	var center := origin.global_position + Vector3(0, height_offset, 0)

	var params := PhysicsShapeQueryParameters3D.new()
	var shape := SphereShape3D.new()
	shape.radius = radius
	params.shape = shape
	params.transform = Transform3D(Basis(), center)
	params.collision_mask = collision_mask
	params.exclude = [origin.get_rid()]

	_draw_debug_if_enabled(origin)
	return space.intersect_shape(params)

func has_line_of_sight(origin: Node3D, target: Node3D) -> bool:
	var space := origin.get_world_3d().direct_space_state
	var params := PhysicsRayQueryParameters3D.new()
	params.from = origin.global_position + Vector3(0, height_offset, 0)
	params.to = target.global_position + Vector3(0, height_offset, 0)
	params.exclude = [origin.get_rid()]
	params.collision_mask = collision_mask
	var result := space.intersect_ray(params)
	return result.is_empty() or result.collider == target

func is_in_range(origin: Node3D, target: Node3D) -> bool:
	return origin.global_position.distance_to(target.global_position) <= radius

func get_random_location(origin: Node3D) -> Vector3:
	var center := origin.global_position + Vector3(0, height_offset, 0)
	var random_pos: Vector3 = center + randf_range(-radius, radius) * Vector3(randf_range(-1, 1), randf_range(-1, 1), randf_range(-1, 1)).normalized()

	return random_pos

func debug_draw_range(origin: Node3D, color: Color = Color(1.0, 0.0, 0.0, 0.35), duration: float = 0.0, segments: int = 32) -> void:
	if origin == null:
		return

	var center := origin.global_position + Vector3(0, height_offset, 0)
	var segment_count = max(3, segments)
	var points := PackedVector3Array()
	points.resize(segment_count + 1)

	for index in range(segment_count + 1):
		var angle := deg_to_rad(index * 360.0 / segment_count)
		points[index] = center + Vector3(cos(angle) * radius, 0.0, sin(angle) * radius)

	if ClassDB.class_exists("DebugDraw3D"):
		DebugDraw3D.draw_line_path(points, color, duration)
		DebugDraw3D.draw_line(points[0], points[segment_count], color, duration)

func _draw_debug_if_enabled(origin: Node3D) -> void:
	if not debug_draw_enabled or origin == null:
		return
	debug_draw_range(origin, debug_draw_color, debug_draw_duration, debug_draw_segments)

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
