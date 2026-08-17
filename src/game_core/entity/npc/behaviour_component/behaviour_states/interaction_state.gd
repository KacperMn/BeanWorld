class_name InteractionState extends BehaviourState

func _init() -> void:
	state_name = "InteractionState"

func enter() -> void:
	super()
	target_location = interacting_character.global_transform.origin
	arrived = false

func physics_update(delta: float) -> void:
	if arrived == true:
		change_state.emit("IdleState")
