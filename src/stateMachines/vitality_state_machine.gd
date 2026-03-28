class_name VitalityStateMachine extends StateMachine

func setup(entity: Entity) -> void:
	_register(AliveState.new(), entity)
	_register(HurtState.new(), entity)
	_register(DeadState.new(), entity)
	start(get_state("AliveState"))

func _register(state: VitalityState, entity: Entity) -> void:
	state.entity = entity
	state.vitality_sm = self
	states[state.state_name] = state
