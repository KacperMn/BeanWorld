class_name StandState extends MovementState

func _init() -> void:
	state_name = "StandState"

func handle(delta: float) -> void:
	velocity.x = move_toward(velocity.x, 0.0, speed * delta * 10)
	velocity.z = move_toward(velocity.z, 0.0, speed * delta * 10)
	if is_on_floor and provider.wants_jump():
		change_state.emit("JumpState")
		return
	if provider.get_direction() != Vector3.ZERO:
		change_state.emit("WalkState")
