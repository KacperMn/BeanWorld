class_name WalkState extends GroundedMovingState

func _init() -> void:
	state_name = "WalkState"

func handle(delta: float) -> void:
	super(delta)
	if movement_sm.wants_sprint():
		change_state.emit("SprintState")
		return
