class_name FightingState extends ActivityState

func _init() -> void:
	state_name = "FightingState"

func physics_update(delta: float) -> void:
	if !is_in_combat:
		change_state.emit("WanderState")