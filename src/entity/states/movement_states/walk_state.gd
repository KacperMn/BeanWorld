class_name WalkState extends MovementState

func _init() -> void:
	state_name = "WalkState"

func handle(delta: float) -> void:
	if entity.is_on_floor() and provider.wants_jump():
		movement_sm.transition_to("JumpState")
		return
	if provider.get_direction(entity) == Vector3.ZERO:
		movement_sm.transition_to("IdleState")
		return
	if provider.wants_sprint():
		movement_sm.transition_to("SprintState")
		return
	apply_movement(delta, entity.speed)
	rotate_entity_to_velocity(delta)
