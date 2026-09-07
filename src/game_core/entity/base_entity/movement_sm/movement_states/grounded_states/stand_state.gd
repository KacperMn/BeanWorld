class_name StandState extends GroundedState

func _init() -> void:
	state_name = "StandState"

func handle(delta: float) -> void:
	character_body.velocity.x = move_toward(character_body.velocity.x, 0.0, stats_component.movement_speed * delta * 10)
	character_body.velocity.z = move_toward(character_body.velocity.z, 0.0, stats_component.movement_speed * delta * 10)
	if movement_sm.get_move_direction() != Vector3.ZERO:
		if movement_sm.wants_sprint():
			change_state.emit("SprintState")
		else:
			change_state.emit("WalkState")
	super(delta)
