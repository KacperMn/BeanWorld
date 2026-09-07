class_name JumpState extends AirborneState

func _init() -> void:
	state_name = "JumpState"

func enter() -> void:
	super()
	character_body.velocity.y += stats_component.jump_force