class_name NPCMovementProvider extends MovementProvider

var NO_TARGET: Vector3 = Vector3.INF
var path_position: Vector3 = NO_TARGET
var toggle_sprint: bool = false

func clear_target() -> void:
	path_position = NO_TARGET

func get_direction() -> Vector3:
	if path_position != NO_TARGET:
		var direction = Vector3(path_position.x - entity.global_transform.origin.x, 0, path_position.z - entity.global_transform.origin.z)
		return direction.normalized()
	else:
		return Vector3.ZERO

func wants_sprint() -> bool:
	return toggle_sprint