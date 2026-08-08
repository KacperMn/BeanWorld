class_name ActivitySM extends StateMachine

func setup() -> void:
	super()

func set_is_in_combat(is_in_combat: bool) -> void:
	current_state.is_in_combat = is_in_combat