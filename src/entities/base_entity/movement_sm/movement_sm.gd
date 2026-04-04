class_name MovementSM extends StateMachine

@export var movement_provider: MovementProvider = MovementProvider.new()
@export var movement_states: Array[MovementState] = [IdleState.new(), FallState.new(), WalkState.new()]

func setup() -> void:
    print(movement_provider)
    provider = movement_provider
    states = movement_states
    super()