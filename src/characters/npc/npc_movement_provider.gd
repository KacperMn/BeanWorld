class_name NPCMovementProvider extends MovementProvider

var target_location: Variant
var npc_position: Vector3

func set_npc_location_data(position: Vector3, target: Variant) -> void:
	npc_position = position
	target_location = target

func get_direction() -> Vector3:
	if target_location != null:
		var direction = Vector3(target_location.x - npc_position.x, 0, target_location.z - npc_position.z)
		return direction.normalized()
	else:
		return Vector3.ZERO
