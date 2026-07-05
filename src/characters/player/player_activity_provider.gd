class_name PlayerActivityProvider extends ActivityProvider

func get_combat_state() -> bool:
	if entity.is_in_combat:
		return true
	else:
		return false

func wants_to_change_mode() -> bool:
	if Input.is_action_just_pressed("switch_camera_mode"):
		print("Switching camera mode")
		return true
	else:
		return false