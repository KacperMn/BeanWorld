class_name ExplorationState extends PlayModeState

func _init() -> void:
	state_name = "ExplorationState"

func physics_update(_delta: float) -> void:
	if is_in_combat:
		change_state.emit("FightingState")
	if wants_to_change_mode() && !is_in_combat:
		change_state.emit("BuildingState")