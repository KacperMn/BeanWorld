class_name MeleeAttack extends Action

@export var damage: float = 10.0
@export var range_query: RangeQuery = RangeQuery.new()

func on_activate() -> void:
	var forward := _get_forward()
	var hits := range_query.get_entities_in_range(_slot.entity, forward)
	for entity in hits:
		_slot.entity.enter_combat()
		entity.hurt(damage)

func _get_forward() -> Vector3:
	if _slot.entity is Player:
		return -_slot.entity.camera_controller.camera_arm.global_transform.basis.z
	return -_slot.entity.global_transform.basis.z