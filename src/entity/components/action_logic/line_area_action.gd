class_name LineAreaAction extends AreaAction

@export var length: float = 6.0

func _get_targets() -> Array[Entity]:
	var results: Array[Entity] = []
	if _slot.entity == null:
		return results

	var forward := _get_forward().normalized()
	var space := _slot.entity.get_world_3d().direct_space_state
	var params := PhysicsRayQueryParameters3D.new()
	params.from = _slot.entity.global_position
	params.to = _slot.entity.global_position + forward * length
	params.exclude = [_slot.entity.get_rid()]
	params.collision_mask = collision_mask

	var hit := space.intersect_ray(params)
	if hit.is_empty():
		return results

	var body = hit.collider
	if body is Entity:
		results.append(body)
	return results
