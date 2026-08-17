class_name ExplorationMode extends PlayModeState

func _init() -> void:
	state_name = "ExplorationMode"

func physics_update(_delta: float) -> void:
	if is_in_combat:
		change_state.emit("FightMode")
	if wants_to_change_mode() && !is_in_combat:
		change_state.emit("BuildingMode")