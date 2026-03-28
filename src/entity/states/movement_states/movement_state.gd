class_name MovementState extends State

var provider: MovementProvider
var movement_sm: MovementStateMachine

var _air_speed: float = 0.0

func physics_update(delta: float) -> void:
	_air_speed = Vector2(entity.velocity.x, entity.velocity.z).length()
	if _air_speed < entity.speed:
		_air_speed = entity.speed
	if not entity.is_on_floor() and entity.velocity.y < 0.0:
		if movement_sm.current_state != movement_sm.states["FallState"]:
			movement_sm.states["FallState"]._air_speed = _air_speed
			movement_sm.transition_to("FallState")
			return
	handle(delta)

func handle(_delta: float) -> void:
	pass

func apply_movement(delta: float, move_speed: float) -> void:
	var direction := provider.get_direction(entity)
	if move_speed < entity.velocity.length():
		entity.velocity.x = move_toward(entity.velocity.x, direction.x * move_speed, move_speed * delta * 100)
		entity.velocity.z = move_toward(entity.velocity.z, direction.z * move_speed, move_speed * delta * 100)
	entity.velocity.x = move_toward(entity.velocity.x, direction.x * move_speed, move_speed * delta * 10)
	entity.velocity.z = move_toward(entity.velocity.z, direction.z * move_speed, move_speed * delta * 10)

func rotate_entity_to_velocity(delta: float, speed: float = 10.0) -> void:
	var vel := Vector2(entity.velocity.x, entity.velocity.z)
	if vel.length() < entity.speed * 0.15:
		return
	var target_angle := atan2(-vel.x, -vel.y)
	entity.rotation.y = lerp_angle(entity.rotation.y, target_angle, speed * delta)

func apply_air_control(delta: float, influence: float = 1.0) -> void:
	var direction := provider.get_direction(entity)
	entity.velocity.x = move_toward(entity.velocity.x, direction.x * _air_speed * influence, _air_speed * delta * 10)
	entity.velocity.z = move_toward(entity.velocity.z, direction.z * _air_speed * influence, _air_speed * delta * 10)

func land() -> void:
	if provider.get_direction(entity) == Vector3.ZERO:
		movement_sm.transition_to("IdleState")
	elif provider.wants_sprint():
		movement_sm.transition_to("SprintState")
	else:
		movement_sm.transition_to("WalkState")
