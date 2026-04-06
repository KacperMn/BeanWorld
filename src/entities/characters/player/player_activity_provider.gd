class_name PlayerActivityProvider extends ActivityProvider

func get_wants_to_build(state_name: String) -> void:
	if Input.is_action_just_pressed("switch_camera_mode"):
		if state_name == "ExplorationState":
			entity.activity_sm.transition_to("BuildingState")
		elif state_name == "BuildingState":
			entity.activity_sm.transition_to("ExplorationState")