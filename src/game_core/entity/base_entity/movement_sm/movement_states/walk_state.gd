class_name WalkState extends MovementState

func _init() -> void:
	state_name = "WalkState"

func handle(delta: float) -> void:
	if character_body.is_on_floor() and provider.wants_jump():
		change_state.emit("JumpState")
		return
	if provider.get_direction() == Vector3.ZERO:
		change_state.emit("StandState")
		return
	if provider.wants_sprint():
		change_state.emit("SprintState")
		return
	calculate_movement(delta, stats_component.movement_speed)
	rotate_entity_to_velocity(delta)
