class_name JumpState extends MovementState

func _init() -> void:
	state_name = "JumpState"

func enter() -> void:
	super()
	character_body.velocity.y += stats_component.jump_force

func handle(delta: float) -> void:
	if character_body.velocity.y > 0.0:
		character_body.velocity.y = move_toward(character_body.velocity.y, 0.0, stats_component.movement_speed * delta * 10)
	rotate_entity_to_velocity(delta)
	apply_air_control(delta)
