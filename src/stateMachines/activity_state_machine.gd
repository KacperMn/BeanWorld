class_name ActivityStateMachine extends StateMachine

func setup(entity: Entity) -> void:
	_register(ExplorationState.new(), entity)
	_register(CombatState.new(), entity)
	_register(BuildingState.new(), entity)
	start(get_state("ExplorationState"))

func _register(state: ActivityState, entity: Entity) -> void:
	state.entity = entity
	state.activity_sm = self
	states[state.state_name] = state
