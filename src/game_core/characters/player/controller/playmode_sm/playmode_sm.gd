class_name PlayModeSM extends StateMachine

func setup_sm() -> void:
	add_states([ExplorationMode.new(), BuildingMode.new(), FightMode.new()])
	current_state = get_state("ExplorationMode")
	super()

func switch_playmode() -> void:
	if current_state is FightMode:
		return
	if current_state is ExplorationMode:
		transition_to("BuildingMode")
	elif current_state is BuildingMode:
		transition_to("ExplorationMode")

func _on_combat_entered() -> void:
	transition_to("FightMode")

func _on_combat_left() -> void:
	print("Combat left, switching to ExplorationMode")
	transition_to("ExplorationMode")
