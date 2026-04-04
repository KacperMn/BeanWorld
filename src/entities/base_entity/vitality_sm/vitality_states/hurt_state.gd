class_name HurtState extends VitalityState

@export var hurt_duration: float = 0.5
var _timer: float = 0.0

func _init() -> void:
    state_name = "HurtState"

func on_enter() -> void:
    provider.is_invincible = true
    _timer = hurt_duration

func on_exit() -> void:
    provider.is_invincible = false

func handle(delta: float) -> void:
    _timer -= delta
    if _timer <= 0.0:
        state_machine.transition_to("AliveState")

func _on_died() -> void:
    state_machine.transition_to("DeadState")