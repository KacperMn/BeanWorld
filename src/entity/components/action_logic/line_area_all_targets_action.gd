class_name LineAreaAllTargetsAction extends AreaAction

@export var length: float = 6.0
@export var step: float = 1.0

func _get_targets() -> Array[Entity]:
	var results: Array[Entity] = []
	if _slot.entity == null:
		return results

	var forward := _get_forward().normalized()
	var space := _slot.entity.get_world_3d().direct_space_state
	var segment_count := int(ceil(length / step))
	var origin := _slot.entity.global_position

	for index in range(segment_count):
		var sample_offset := forward * (index * step)
		var params := PhysicsShapeQueryParameters3D.new()
		var shape := BoxShape3D.new()
		shape.size = Vector3(0.25, 0.25, step)
		params.shape = shape
		params.transform = Transform3D(Basis().looking_at(forward, Vector3.UP), origin + sample_offset)
		params.collision_mask = collision_mask
		params.exclude = [_slot.entity.get_rid()]

		var hits := space.intersect_shape(params)
		for hit in hits:
			var body = hit.collider
			if body is Entity and not _contains_entity(results, body):
				results.append(body)

	return results

func _contains_entity(items: Array[Entity], candidate: Entity) -> bool:
	for entity in items:
		if entity == candidate or entity.get_instance_id() == candidate.get_instance_id():
			return true
	return false
