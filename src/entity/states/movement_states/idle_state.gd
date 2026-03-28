class_name IdleState extends MovementState

func _init() -> void:
    state_name = "IdleState"

func handle(delta: float) -> void:
    var stateMachine: MovementStateMachine = entity.movement_sm

    entity.velocity.x = move_toward(entity.velocity.x, 0.0, entity.speed * delta * 10)
    entity.velocity.z = move_toward(entity.velocity.z, 0.0, entity.speed * delta * 10)

    if entity.is_on_floor() and provider.wants_jump():
        stateMachine.transition_to("JumpState")
        return
    if provider.get_direction(entity) != Vector3.ZERO:
        stateMachine.transition_to("WalkState")