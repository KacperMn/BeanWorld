class_name NPCMovementProvider extends MovementProvider

func get_direction(entity: Entity) -> Vector3:
    if not enabled or not entity.target_location:
        return Vector3.ZERO
    var direction: Vector3 = entity.target_location - entity.global_transform.origin
    direction.y = 0.0
    return direction.normalized()