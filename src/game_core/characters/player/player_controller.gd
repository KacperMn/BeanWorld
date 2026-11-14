class_name PlayerController extends Controller

var camera_arm: Node3D
var movement: MovementComponent
var action_component: ActionComponent

func setup(_camera_arm: Node3D, _movement: MovementComponent, _action_component: ActionComponent) -> void:
	camera_arm = _camera_arm
	movement = _movement
	action_component = _action_component

func _process(_delta: float) -> void:
	process_movement_input()
	process_action_input()

func process_movement_input() -> void:
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var dir := camera_arm.global_transform.basis * Vector3(input_dir.x, 0, input_dir.y)
	dir.y = 0.0
	movement.set_move_direction(dir.normalized())
	movement.toggle_sprint(Input.is_action_pressed("sprint"))
	if Input.is_action_pressed("jump"):
		movement.jump()

func process_action_input() -> void:
	if Input.is_action_just_pressed("primary_action"):
		action_component.try_use("primary_action")
	if Input.is_action_just_pressed("secondary_action"):
		action_component.try_use("secondary_action")
