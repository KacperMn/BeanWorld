class_name HurtState extends State


func _init() -> void:
    state_name = "HurtState"

@export var hurt_duration: float = 0.4
var _timer: float = 0.0

func enter() -> void:
    _timer = hurt_duration
    on_enter()

func update(delta: float) -> void:
    _timer -= delta
    if _timer <= 0.0:
        on_expired()

func on_enter() -> void:
    pass  # override: knockback, sound, etc.

func on_expired() -> void:
    pass  # override: transition back to idle