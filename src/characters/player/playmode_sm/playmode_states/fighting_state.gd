class_name FightingState extends PlayModeState

func _init() -> void:
	state_name = "FightingState"

func physics_update(_delta: float) -> void:
	if !is_in_combat:
		change_state.emit("ExplorationState")