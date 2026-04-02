class_name MeleeAttack extends Action

@export var damage: float = 10.0
@export var cone_angle: float = 90.0

func update(delta: float) -> void:
	super (delta)
	_draw_debug_cone()


func on_activate() -> void:
	var hits: Array = _slot.entity.get_node("MeleeRange").get_entities_in_cone(cone_angle)
	for entity in hits:
		entity.hurt(damage)
	print("Melee attack activated. Hit ", hits.size(), " entities.")
	_draw_debug_cone()

func _draw_debug_cone() -> void:
	if _slot.entity is not Player:
		return
	var forward = - _slot.entity.camera_controller.camera_arm.global_transform.basis.z
	forward.y = 0.0
	forward = forward.normalized()
	var half := deg_to_rad(cone_angle / 2.0)
	var range_r = _slot.entity.get_node("MeleeRange").get_child(0).shape.radius

	# draw left and right edges of cone
	var left = forward.rotated(Vector3.UP, half) * range_r
	var right = forward.rotated(Vector3.UP, -half) * range_r
	var origin = _slot.entity.global_position

	DebugDraw3D.draw_line(origin, origin + left, Color.GREEN)
	DebugDraw3D.draw_line(origin, origin + right, Color.GREEN)
	DebugDraw3D.draw_line(origin, origin + forward * range_r, Color.RED)
