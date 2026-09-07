class_name GroundedMovingState extends GroundedState

var multiplier: float = 1.0

func handle(delta: float) -> void:
	if movement_sm.get_move_direction() == Vector3.ZERO:
		change_state.emit("StandState")
		return
	calculate_movement(delta, stats_component.movement_speed * multiplier)
	rotate_entity_to_velocity(delta)
	super(delta)

func calculate_movement(delta: float, move_speed: float) -> void:
	var direction = movement_sm.get_move_direction()
	if move_speed < character_body.velocity.length():
		character_body.velocity.x = move_toward(character_body.velocity.x, direction.x * move_speed, move_speed * delta * 100)
		character_body.velocity.z = move_toward(character_body.velocity.z, direction.z * move_speed, move_speed * delta * 100)
	character_body.velocity.x = move_toward(character_body.velocity.x, direction.x * move_speed, move_speed * delta * 10)
	character_body.velocity.z = move_toward(character_body.velocity.z, direction.z * move_speed, move_speed * delta * 10)