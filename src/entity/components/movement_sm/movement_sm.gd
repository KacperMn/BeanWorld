class_name MovementSM extends StateMachine

func setup() -> void:
	if not provider:
		provider = MovementProvider.new()
	add_states([StandState.new(), FallState.new()])
	current_state = states[states.find(StandState)]
	super ()
