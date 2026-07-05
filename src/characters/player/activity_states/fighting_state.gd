class_name FightingState extends ActivityState

func _init() -> void:
	state_name = "FightingState"

func physics_update(delta: float) -> void:
	if !provider.get_combat_state():
		state_machine.transition_to("ExplorationState")