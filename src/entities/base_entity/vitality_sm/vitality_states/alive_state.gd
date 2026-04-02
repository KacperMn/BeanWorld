class_name AliveState extends VitalityState

func _init() -> void:
    state_name = "AliveState"

func enter() -> void:
    entity.movement_provider.enabled = true
    # connect to health provider signals
    entity.health_provider.died.connect(_on_died)

func exit() -> void:
    entity.health_provider.died.disconnect(_on_died)

func on_hurt(amount: float) -> void:
    entity.health_provider.hurt(amount)
    if entity.health_provider.health > 0.0:
        state_machine.transition_to("HurtState")

func on_heal(amount: float) -> void:
    entity.health_provider.heal(amount)

func _on_died() -> void:
    state_machine.transition_to("DeadState")