class_name SprintState extends GroundedMovingState

func _init() -> void:
    state_name = "SprintState"
    multiplier = 1.8

func handle(delta: float) -> void:
    super(delta)
    if not movement_sm.wants_sprint():
        change_state.emit("WalkState")
        return