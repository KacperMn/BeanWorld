class_name AliveState extends VitalityState

func _init() -> void:
    state_name = "AliveState"

func on_enter() -> void:
    entity.movement_sm.provider.enabled = true

func _on_health_changed(_old: float, new_val: float) -> void:
    if not provider.is_dead and new_val < _old:
        state_machine.transition_to("HurtState")

func _on_died() -> void:
    state_machine.transition_to("DeadState")