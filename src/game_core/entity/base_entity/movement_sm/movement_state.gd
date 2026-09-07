class_name MovementState extends State

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

var movement_sm: MovementComponent
var stats_component: StatsComponent
var character_body: CharacterBody3D

func physics_update(delta: float) -> void:
	handle(delta)
	handle_gravity(delta)

func handle(_delta: float) -> void:
	pass

func enter() -> void:
	print("Entering state: %s" % state_name)
	super()

func handle_gravity(delta: float) -> void:
	if not character_body.is_on_floor():
		character_body.velocity.y -= gravity * delta
	if not character_body.is_on_floor() and character_body.velocity.y < 0.0 and state_name != "FallState":
		change_state.emit("FallState")

func rotate_entity_to_velocity(delta: float) -> void:
	var vel := Vector2(character_body.velocity.x, character_body.velocity.z)
	if vel.length() < stats_component.movement_speed * 0.15:
		return
	var target_angle := atan2(-vel.x, -vel.y)
	character_body.rotation.y = lerp_angle(character_body.rotation.y, target_angle, stats_component.movement_speed * delta)
