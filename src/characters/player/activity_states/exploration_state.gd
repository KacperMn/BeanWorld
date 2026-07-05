class_name ExplorationState extends ActivityState

func _init() -> void:
	state_name = "ExplorationState"

func physics_update(delta: float) -> void:
	if provider.get_combat_state():
		state_machine.transition_to("FightingState")
	if provider.wants_to_change_mode() && !entity.is_in_combat:
		state_machine.transition_to("BuildingState")