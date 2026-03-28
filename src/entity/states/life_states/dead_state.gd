class_name DeadState extends VitalityState


func _init() -> void:
    state_name = "DeadState"

func handle(_delta: float) -> void:
    if entity.health > 0.0:
        entity.vitality_sm.transition_to("AliveState")

func enter() -> void:
    entity.die()
    entity.movement_provider.enabled = false