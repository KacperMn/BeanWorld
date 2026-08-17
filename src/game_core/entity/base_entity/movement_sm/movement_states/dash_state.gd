class_name DashState extends MovementState

var dash_distance: float = 10.0
var start_position: Vector3

func _init() -> void:
	state_name = "DashState"

func enter() -> void:
	super()
	var direction = provider.get_direction()
	if direction == Vector3.ZERO:
		direction = Vector3(-sin(character_body.rotation.y), 0, -cos(character_body.rotation.y))
	start_position = character_body.position
	character_body.velocity = direction.normalized() * stats_component.movement_speed * 10.0

func handle(delta: float) -> void:
	if not provider.wants_jump() and character_body.velocity.y > 0.0:
		character_body.velocity.y = move_toward(character_body.velocity.y, 0.0, stats_component.movement_speed * delta * 4)
	var traveled_distance := (character_body.position - start_position).length()
	if traveled_distance >= dash_distance || character_body.velocity.length() == 0.0:
		land()
