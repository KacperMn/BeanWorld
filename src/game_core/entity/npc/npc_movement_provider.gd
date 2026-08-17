class_name NPCMovementProvider extends MovementProvider

var path_position: Vector3
var should_walk: bool = false

func get_direction() -> Vector3:
	if should_walk == false:
		return Vector3.ZERO
	if path_position != null:
		var direction = Vector3(path_position.x - entity.global_transform.origin.x, 0, path_position.z - entity.global_transform.origin.z)
		return direction.normalized()
	else:
		return Vector3.ZERO
