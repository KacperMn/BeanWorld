class_name HurtState extends VitalityState

@export var hurt_duration: float = 0.5
var _timer: float = 0.0

func _init() -> void:
    state_name = "HurtState"

func enter() -> void:
    entity.health_provider.is_invincible = true
    _timer = hurt_duration

func exit() -> void:
    entity.health_provider.is_invincible = false

func handle(delta: float) -> void:
    _timer -= delta
    if _timer <= 0.0:
        state_machine.transition_to("AliveState")

func on_hurt(_amount: float) -> void:
    pass # invincible during hurt

func on_heal(amount: float) -> void:
    entity.health_provider.heal(amount)