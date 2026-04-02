class_name VitalityState extends State

func handle(_delta: float) -> void:
    pass

func physics_update(_delta: float) -> void:
    _handle_debug_input()
    handle(_delta)

func on_hurt(amount: float) -> void:
    provider.hurt(amount)

func on_heal(amount: float) -> void:
    provider.heal(amount)

func _handle_debug_input() -> void:
    if Input.is_action_just_pressed("kill"):
        entity.health_provider.hurt(entity.health_provider.health)
    if Input.is_action_just_pressed("revive"):
        entity.health_provider.revive()