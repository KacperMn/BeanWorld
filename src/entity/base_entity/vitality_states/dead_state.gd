class_name DeadState extends VitalityState

func _init() -> void:
    state_name = "DeadState"

func on_enter() -> void:
    entity.movement_sm.provider.enabled = false

func _on_revived() -> void:
    state_machine.transition_to("AliveState")