class_name MovementState extends State

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

var velocity: Vector3
var rotation: Vector3

var is_on_floor: bool
var speed: float
var position: Vector3

var _air_speed: float = 0.0

func physics_update(delta: float) -> void:
	calculate_airspeed()
	handle(delta)
	handle_gravity(delta)

func handle(_delta: float) -> void:
	pass

func handle_gravity(delta: float) -> void:
	if not is_on_floor:
		velocity.y -= gravity * delta
	if not is_on_floor and velocity.y < 0.0 and state_name != "FallState":
		change_state.emit("FallState")
		
func calculate_airspeed() -> void:
	_air_speed = Vector2(velocity.x, velocity.z).length()
	if _air_speed < speed:
		_air_speed = speed
	
func calculate_movement(delta: float, move_speed: float) -> void:
	var direction = provider.get_direction()
	if move_speed < velocity.length():
		velocity.x = move_toward(velocity.x, direction.x * move_speed, move_speed * delta * 100)
		velocity.z = move_toward(velocity.z, direction.z * move_speed, move_speed * delta * 100)
	velocity.x = move_toward(velocity.x, direction.x * move_speed, move_speed * delta * 10)
	velocity.z = move_toward(velocity.z, direction.z * move_speed, move_speed * delta * 10)

func rotate_entity_to_velocity(delta: float) -> void:
	var vel := Vector2(velocity.x, velocity.z)
	if vel.length() < speed * 0.15:
		return
	var target_angle := atan2(-vel.x, -vel.y)
	rotation.y = lerp_angle(rotation.y, target_angle, speed * delta)

func apply_air_control(delta: float) -> void:
	var direction = provider.get_direction()
	velocity.x = move_toward(velocity.x, direction.x * _air_speed, _air_speed * delta * 10)
	velocity.z = move_toward(velocity.z, direction.z * _air_speed, _air_speed * delta * 10)

func land() -> void:
	velocity.y = 0.0
	if provider.get_direction() != Vector3.ZERO:
		change_state.emit("WalkState")
	elif provider.wants_sprint():
		change_state.emit("SprintState")
	else:
		change_state.emit("StandState")
