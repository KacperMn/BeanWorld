class_name BuildingState extends PlayModeState

func _init() -> void:
	state_name = "BuildingState"

func physics_update(_delta: float) -> void:
	if is_in_combat:
		change_state.emit("FightingState")
	if wants_to_change_mode() && not is_in_combat:
		change_state.emit("ExplorationState")
