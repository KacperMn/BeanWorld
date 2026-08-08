class_name MeleeAttack extends Action

@export var damage: float = 10.0
@export var range_query: RangeQuery = RangeQuery.new()

func on_activate() -> void:
	var forward := _get_forward()
	var hits := range_query.get_entities_in_range(_slot.entity, forward)
	for entity in hits:
		if _is_same_entity(entity, _slot.entity):
			continue
		print("MeleeAttack: applying damage to entity %s" % entity + " with damage %f" % damage)
		_slot.entity.combat_sm.enter_combat()
		entity.hurt(damage)

func _is_same_entity(candidate: Entity, source: Entity) -> bool:
	if candidate == null or source == null:
		return false
	if candidate == source:
		return true
	if candidate.get_instance_id() == source.get_instance_id():
		return true
	if candidate.get_path() == source.get_path():
		return true
	return false

func _get_forward() -> Vector3:
	if _slot.entity is Player:
		return -_slot.entity.camera_controller.camera_arm.global_transform.basis.z
	return -_slot.entity.global_transform.basis.z
