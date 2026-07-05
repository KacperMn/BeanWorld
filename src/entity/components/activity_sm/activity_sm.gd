class_name ActivitySM extends StateMachine

func setup() -> void:
	if states.is_empty():
		return
	if not provider:
		provider = ActivityProvider.new()
	super()
