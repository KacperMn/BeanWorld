class_name PlayerController extends Controller

var camera_arm: Node3D
var movement: MovementComponent

func setup(_camera_arm: Node3D, _movement: MovementComponent) -> void:
	camera_arm = _camera_arm
	movement = _movement

func _process(_delta: float) -> void:
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var dir := camera_arm.global_transform.basis * Vector3(input_dir.x, 0, input_dir.y)
	dir.y = 0.0
	movement.set_move_direction(dir.normalized())
	movement.toggle_sprint(Input.is_action_pressed("sprint"))
	if Input.is_action_pressed("jump"):
		movement.jump()