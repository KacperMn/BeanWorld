class_name ActivitySM extends StateMachine

@export var activity_provider: ActivityProvider = ActivityProvider.new()
@export var activity_states: Array[ActivityState] = []

func setup() -> void:
    provider = activity_provider
    states = activity_states
    super()