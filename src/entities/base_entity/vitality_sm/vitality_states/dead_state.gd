class_name DeadState extends VitalityState

func _init() -> void:
    state_name = "DeadState"

func enter() -> void:
    entity.movement_provider.enabled = false
    entity.health_provider.revived.connect(_on_revived)

func exit() -> void:
    entity.health_provider.revived.disconnect(_on_revived)

func on_hurt(_amount: float) -> void:
    pass # dead, ignore

func on_heal(_amount: float) -> void:
    pass # dead, ignore

func _on_revived() -> void:
    state_machine.transition_to("AliveState")