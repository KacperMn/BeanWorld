class_name NPCMovementProvider extends MovementProvider

func get_direction(_entity: Entity) -> Vector3:
	if entity.activity_sm.provider.target_location != null:
		var direction = Vector3(entity.activity_sm.provider.target_location.x - entity.global_position.x, 0, entity.activity_sm.provider.target_location.z - entity.global_position.z)
		return direction.normalized()
	else:
		return Vector3.ZERO
