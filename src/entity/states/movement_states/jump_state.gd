class_name JumpState extends MovementState

@export var jump_force: float = 5.0

func _init() -> void:
	state_name = "JumpState"

func enter() -> void:
	if entity.jump_force != null:
		jump_force = entity.jump_force
	entity.velocity.y = jump_force

func handle(delta: float) -> void:
	if not provider.wants_jump() and entity.velocity.y > 0.0:
		entity.velocity.y = move_toward(entity.velocity.y, 0.0, entity.speed * delta * 10)
	apply_air_control(delta)
	rotate_entity_to_velocity(delta)
	if entity.is_on_floor():
		land()
