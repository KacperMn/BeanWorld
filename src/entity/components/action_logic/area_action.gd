class_name AreaAction extends Action

@export var collision_mask: int = 1

func on_activate() -> void:
	var targets := _get_targets()
	for entity in targets:
		if _is_same_entity(entity, _slot.entity):
			continue
		_apply_effect(entity)

func _get_targets() -> Array[Entity]:
	return []

func _apply_effect(_entity: Entity) -> void:
	pass

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
