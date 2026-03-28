# movement_state_machine.gd
class_name MovementStateMachine extends StateMachine

func setup(entity: Entity, provider: MovementProvider) -> void:
    _register(IdleState.new(), entity, provider)
    _register(WalkState.new(), entity, provider)
    _register(SprintState.new(), entity, provider)
    _register(JumpState.new(), entity, provider)
    _register(FallState.new(), entity, provider)
    _register(DashState.new(), entity, provider)
    start(get_state("IdleState"))

func _register(state: MovementState, entity: Entity, provider: MovementProvider) -> void:
    state.entity = entity
    state.provider = provider
    state.movement_sm = self
    states[state.state_name] = state