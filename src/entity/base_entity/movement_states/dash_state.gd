class_name DashState extends MovementState

var dash_distance: float = 10.0
var start_position: Vector3

func _init() -> void:
	state_name = "DashState"

func enter() -> void:
	var direction = provider.get_direction(entity)
	if direction == Vector3.ZERO:
		direction = Vector3(-sin(entity.rotation.y), 0, -cos(entity.rotation.y))
	start_position = entity.global_transform.origin
	entity.velocity = direction.normalized() * entity.speed * 10.0
	print("DASH! ", entity.velocity)

func handle(delta: float) -> void:
	if not provider.wants_jump() and entity.velocity.y > 0.0:
		entity.velocity.y = move_toward(entity.velocity.y, 0.0, entity.speed * delta * 4)
	var traveled_distance := (entity.global_transform.origin - start_position).length()
	if traveled_distance >= dash_distance || entity.velocity.length() == 0.0:
		land()
