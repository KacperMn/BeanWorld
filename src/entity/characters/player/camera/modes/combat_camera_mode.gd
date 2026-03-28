class_name CombatCameraMode extends CameraMode

@export var auto_rotate_speed: float = 6.0
@export var auto_rotate_threshold: float = 20.0


func on_enter(controller: CameraController) -> void:
	print("Entered combat camera mode")
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	distance = 10.0

func handle_position(delta: float, controller: CameraController) -> void:
	# controller.global_position = Vector3(
	# 	controller.target.global_position.x,
	# 	controller.target.global_position.y + controller.vertical_offset,
	# 	controller.target.global_position.z
	# )
	pass

func handle_rotation(delta: float, controller: CameraController) -> void:
	controller.yaw -= controller.input_direction.x * delta
	controller.pitch -= controller.input_direction.y * delta
	controller.pitch = clampf(controller.pitch, deg_to_rad(min_pitch), deg_to_rad(max_pitch))