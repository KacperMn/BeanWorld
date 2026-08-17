class_name FightMode extends PlayModeState

func _init() -> void:
	state_name = "FightMode"

func physics_update(_delta: float) -> void:
	if !is_in_combat:
		change_state.emit("ExplorationMode")