extends Node3D

@export_range(0.0, 1.0) var mouse_sensitivity: float = 0.5
@onready var camera: Camera3D = $Camera

var input_direction: Vector2 = Vector2.ZERO

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel") and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	elif event.is_action_pressed("ui_accept") and Input.mouse_mode != Input.MOUSE_MODE_CAPTURED:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	_unhandled_input(event)

func _unhandled_input(event: InputEvent) -> void:
	var is_camera_motion: bool = (
		event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED
	)
	if is_camera_motion:
		input_direction = event.screen_relative * mouse_sensitivity * mouse_sensitivity

func _physics_process(delta: float) -> void:
	rotation.x += input_direction.y * delta
	rotation.x = clamp(rotation.x, PI / -6.0, PI / 3.0)
	rotation.y -= input_direction.x * delta
	input_direction = Vector2.ZERO