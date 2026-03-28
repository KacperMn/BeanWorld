class_name MeleeRange extends Area3D

@onready var self_entity: Entity = get_parent()

func _ready() -> void:
	pass

func get_entities_in_range() -> Array:
	var entities_in_range: Array = []
	for body in get_overlapping_bodies():
		if body is Entity and body != self_entity:
			entities_in_range.append(body)
	return entities_in_range

func get_entities_in_cone(cone_angle: float) -> Array:
	var entities_in_cone: Array = []
	var camera_arm = self_entity.camera_controller.camera_arm
	var forward = - camera_arm.global_transform.basis.z
	forward.y = 0.0
	forward = forward.normalized()

	var half_angle := deg_to_rad(cone_angle / 2.0)

	for entity in get_entities_in_range():
		var to_target = entity.global_position - self_entity.global_position
		to_target.y = 0.0
		to_target = to_target.normalized()

		var dot = forward.dot(to_target)

		if dot >= cos(half_angle):
			entities_in_cone.append(entity)

	return entities_in_cone
