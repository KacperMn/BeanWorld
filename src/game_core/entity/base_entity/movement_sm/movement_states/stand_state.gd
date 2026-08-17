class_name StandState extends MovementState

func _init() -> void:
	state_name = "StandState"

func handle(delta: float) -> void:
	character_body.velocity.x = move_toward(character_body.velocity.x, 0.0, stats_component.movement_speed * delta * 10)
	character_body.velocity.z = move_toward(character_body.velocity.z, 0.0, stats_component.movement_speed * delta * 10)
	if character_body.is_on_floor() and provider.wants_jump():
		change_state.emit("JumpState")
		return
	if provider.get_direction() != Vector3.ZERO:
		change_state.emit("WalkState")
