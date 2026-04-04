class_name VitalitySM extends StateMachine

@export var health_provider: HealthProvider = HealthProvider.new()
@export var vitality_states: Array[VitalityState]

func setup() -> void:
    provider = health_provider
    states = vitality_states
    super()

func hurt(amount: float) -> void:
    health_provider.hurt(amount)

func heal(amount: float) -> void:
    health_provider.heal(amount)

func revive() -> void:
    health_provider.revive()