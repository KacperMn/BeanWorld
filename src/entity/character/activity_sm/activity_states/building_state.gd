class_name BuildingState extends ActivityState

func _init() -> void:
	state_name = "BuildingState"

func physics_update(_delta: float) -> void:
	if provider.get_combat_state():
		change_state.emit("FightingState")
	if provider.wants_to_change_mode() && not is_in_combat:
		change_state.emit("ExplorationState")
