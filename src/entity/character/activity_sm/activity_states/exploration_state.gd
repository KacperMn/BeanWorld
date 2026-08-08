class_name ExplorationState extends ActivityState

func _init() -> void:
	state_name = "ExplorationState"

func physics_update(delta: float) -> void:
	if is_in_combat:
		change_state.emit("FightingState")
	if provider.wants_to_change_mode() && !is_in_combat:
		change_state.emit("BuildingState")