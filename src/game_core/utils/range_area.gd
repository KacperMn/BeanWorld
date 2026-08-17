class_name RangeArea
extends Area3D

@export var radius: float = 2.0
@export var cone_angle: float = 360.0
@export var collision_mask_override: int = 1 << 0

@onready var collision_shape: CollisionShape3D = $CollisionShape

func _ready() -> void:
	collision_mask = collision_mask_override
	_update_shape()

func get_entities_in_range(forward: Vector3 = Vector3.ZERO) -> Array[Entity]:
	var results: Array[Entity] = []
	for body in get_overlapping_bodies():
		if not body is Entity:
			continue
		if _is_excluded(body, forward):
			continue
		results.append(body)
	return results

func get_characters_in_range(forward: Vector3 = Vector3.ZERO) -> Array[Character]:
	var results: Array[Character] = []
	for body in get_overlapping_bodies():
		if not body is Character:
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
	var dir := Vector3(randf_range(-1, 1), 0, randf_range(-1, 1)).normalized()
	return global_transform.origin + dir * randf_range(0.0, radius)

func _update_shape() -> void:
	collision_shape.shape.radius = radius

func _is_excluded(body: Node3D, forward: Vector3) -> bool:
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
