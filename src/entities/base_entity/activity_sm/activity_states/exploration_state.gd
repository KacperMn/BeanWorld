class_name ExplorationState extends ActivityState

func _init() -> void:
	state_name = "ExplorationState"

func update(_delta: float) -> void:
	super(_delta)
	if Input.is_action_just_pressed("switch_camera_mode"):
		if state_machine.current_state.state_name == "ExplorationState":
			state_machine.transition_to("BuildingState")