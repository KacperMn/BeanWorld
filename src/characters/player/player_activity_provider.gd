class_name PlayerActivityProvider extends ActivityProvider

func wants_to_change_mode() -> bool:
	if Input.is_action_just_pressed("switch_camera_mode"):
		print("Switching camera mode")
		return true
	else:
		return false