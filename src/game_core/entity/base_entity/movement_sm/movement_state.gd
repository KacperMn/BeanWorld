class_name MovementState extends State

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

var stats_component: StatsComponent
var character_body: CharacterBody3D

var _air_speed: float = 0.0

func physics_update(delta: float) -> void:
	calculate_airspeed()
	handle(delta)
	handle_gravity(delta)

func handle(_delta: float) -> void:
	pass

func handle_gravity(delta: float) -> void:
	if not character_body.is_on_floor():
		character_body.velocity.y -= gravity * delta
	if not character_body.is_on_floor() and character_body.velocity.y < 0.0 and state_name != "FallState":
		change_state.emit("FallState")
		
func calculate_airspeed() -> void:
	_air_speed = Vector2(character_body.velocity.x, character_body.velocity.z).length()
	if _air_speed < stats_component.movement_speed:
		_air_speed = stats_component.movement_speed
	
func calculate_movement(delta: float, move_speed: float) -> void:
	var direction = provider.get_direction()
	if move_speed < character_body.velocity.length():
		character_body.velocity.x = move_toward(character_body.velocity.x, direction.x * move_speed, move_speed * delta * 100)
		character_body.velocity.z = move_toward(character_body.velocity.z, direction.z * move_speed, move_speed * delta * 100)
	character_body.velocity.x = move_toward(character_body.velocity.x, direction.x * move_speed, move_speed * delta * 10)
	character_body.velocity.z = move_toward(character_body.velocity.z, direction.z * move_speed, move_speed * delta * 10)

func rotate_entity_to_velocity(delta: float) -> void:
	var vel := Vector2(character_body.velocity.x, character_body.velocity.z)
	if vel.length() < stats_component.movement_speed * 0.15:
		return
	var target_angle := atan2(-vel.x, -vel.y)
	character_body.rotation.y = lerp_angle(character_body.rotation.y, target_angle, stats_component.movement_speed * delta)

func apply_air_control(delta: float) -> void:
	var direction = provider.get_direction()
	character_body.velocity.x = move_toward(character_body.velocity.x, direction.x * _air_speed, _air_speed * delta * 10)
	character_body.velocity.z = move_toward(character_body.velocity.z, direction.z * _air_speed, _air_speed * delta * 10)

func land() -> void:
	if provider.get_direction() != Vector3.ZERO:
		change_state.emit("WalkState")
	elif provider.wants_sprint():
		change_state.emit("SprintState")
	else:
		change_state.emit("StandState")
