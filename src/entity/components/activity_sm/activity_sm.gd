class_name ActivitySM extends StateMachine

func setup() -> void:
	if not provider:
		provider = ActivityProvider.new()
	if states.is_empty():
		add_state(IdleState.new())
		current_state = states[states.find(IdleState)]
	super()
