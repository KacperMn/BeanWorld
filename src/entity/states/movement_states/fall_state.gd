class_name FallState extends MovementState

func _init() -> void:
	state_name = "FallState"

func handle(delta: float) -> void:
	apply_air_control(delta)
	rotate_entity_to_velocity(delta)
	if entity.is_on_floor():
		land()
