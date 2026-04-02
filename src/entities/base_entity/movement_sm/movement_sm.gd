class_name MovementSM extends StateMachine

@export var movement_provider: MovementProvider = MovementProvider.new()
@export var movement_states: Array[MovementState] = [IdleState.new(), FallState.new(), WalkState.new()]

func _ready() -> void:
    provider = movement_provider
    states = movement_states