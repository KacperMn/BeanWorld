class_name PlayerWalkState extends WalkState

func physics_update(delta: float) -> void:
    var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_back")

    if input_dir == Vector2.ZERO:
        entity.state_machine.transition_to(entity.idle_state)
        return

    if Input.is_action_just_pressed("jump"):
        entity.state_machine.transition_to(entity.jump_state)
        return

    var direction := (entity.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
    entity.velocity = direction * entity.speed
    entity.move_and_slide()