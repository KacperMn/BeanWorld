class_name HurtState extends VitalityState

@export var hurt_duration: float = 0.2
var _timer: float = 0.0

func _init() -> void:
	state_name = "HurtState"

func enter() -> void:
	is_invincible = true
	_timer = hurt_duration
	super()

func exit() -> void:
	is_invincible = false

func physics_update(delta: float) -> void:
	_timer -= delta
	if _timer <= 0.0:
		change_state.emit("AliveState")
