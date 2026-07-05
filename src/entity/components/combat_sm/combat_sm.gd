class_name CombatSM extends StateMachine

func setup() -> void:
	if not provider:
		provider = CombatProvider.new()
	add_states([PeacefulState.new(), InCombatState.new()])
	for state in states:
		if state is PeacefulState:
			current_state = state
	super()

func enter_combat() -> void:
	provider.enter_combat()

func exit_combat() -> void:
	provider.exit_combat()
