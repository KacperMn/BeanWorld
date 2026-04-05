class_name BuildingState extends ActivityState

func _init() -> void:
	state_name = "BuildingState"

func update(_delta: float) -> void:
	super(_delta)
	if Input.is_action_just_pressed("switch_camera_mode"):
		if state_machine.current_state.state_name == "BuildingState":
			state_machine.transition_to("ExplorationState")