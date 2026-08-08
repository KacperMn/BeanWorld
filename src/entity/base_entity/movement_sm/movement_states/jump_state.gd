class_name JumpState extends MovementState

var jump_force

func _init() -> void:
	state_name = "JumpState"

func enter() -> void:
	super()
	velocity.y = jump_force
	print(velocity.y)

func handle(delta: float) -> void:
	if velocity.y > 0.0:
		velocity.y = move_toward(velocity.y, 0.0, speed * delta * 10)
	rotate_entity_to_velocity(delta)
	apply_air_control(delta)
