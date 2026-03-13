class_name PlayerIdleState extends IdleState

func update(delta: float) -> void:
	var input_dir := Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if input_dir != Vector2.ZERO:
		entity.state_machine.transition_to(entity.walk_state)
	if Input.is_action_just_pressed("jump"):
		entity.state_machine.transition_to(entity.jump_state)
