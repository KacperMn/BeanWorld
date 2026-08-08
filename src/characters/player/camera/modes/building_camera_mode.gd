class_name BuildingCameraMode extends CameraMode

@export var pan_speed: float = 10.0

func on_enter(_controller: CameraController) -> void:
	print("Entered building camera mode")
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	distance = 15.0
	min_pitch = -45.0

func on_exit(_controller: CameraController) -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func handle_position(_delta: float, _controller: CameraController) -> void:
	pass

func handle_rotation(delta: float, controller: CameraController) -> void:
	controller.pitch = deg_to_rad(min_pitch)
	controller.yaw = lerp_angle(controller.yaw, 0.0, 2.0 * delta)