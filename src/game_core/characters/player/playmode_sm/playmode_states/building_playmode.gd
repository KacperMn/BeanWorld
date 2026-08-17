class_name BuildingMode extends PlayModeState

func _init() -> void:
	state_name = "BuildingMode"

func physics_update(_delta: float) -> void:
	if is_in_combat:
		change_state.emit("FightMode")
	if wants_to_change_mode() && not is_in_combat:
		change_state.emit("ExplorationMode")
