class_name AirborneState extends MovementState

func handle(delta: float) -> void:
	apply_air_control(delta)
	rotate_entity_to_velocity(delta)
	if character_body.velocity.y <= 0.0 and character_body.is_on_floor():
		land()
	super(delta)

func apply_air_control(delta: float) -> void:
	var _air_speed: float = Vector2(character_body.velocity.x, character_body.velocity.z).length()
	if _air_speed < stats_component.movement_speed:
		_air_speed = stats_component.movement_speed
	var direction = movement_sm.get_move_direction()
	character_body.velocity.x = move_toward(character_body.velocity.x, direction.x * _air_speed, _air_speed * delta * 10)
	character_body.velocity.z = move_toward(character_body.velocity.z, direction.z * _air_speed, _air_speed * delta * 10)

func land() -> void:
	if movement_sm.get_move_direction() != Vector3.ZERO:
		if movement_sm.wants_sprint():
			change_state.emit("SprintState")
		else:
			change_state.emit("WalkState")
	else:
		change_state.emit("StandState")