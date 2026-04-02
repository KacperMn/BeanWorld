class_name VitalitySM extends StateMachine

@export var health_provider: HealthProvider = HealthProvider.new()
@export var vitality_states: Array[VitalityState]

func _ready() -> void:
	provider = health_provider
	states = vitality_states