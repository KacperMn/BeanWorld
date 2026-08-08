class_name DashState extends MovementState

var dash_distance: float = 10.0
var start_position: Vector3

func _init() -> void:
	state_name = "DashState"

func enter() -> void:
	super()
	var direction = provider.get_direction()
	if direction == Vector3.ZERO:
		direction = Vector3(-sin(rotation.y), 0, -cos(rotation.y))
	start_position = position
	velocity = direction.normalized() * speed * 10.0
	print("DASH! ", velocity)

func handle(delta: float) -> void:
	if not provider.wants_jump() and velocity.y > 0.0:
		velocity.y = move_toward(velocity.y, 0.0, speed * delta * 4)
	var traveled_distance := (position - start_position).length()
	if traveled_distance >= dash_distance || velocity.length() == 0.0:
		land()
