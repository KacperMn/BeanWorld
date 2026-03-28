class_name AliveState extends VitalityState

func _init() -> void:
	state_name = "AliveState"

func enter() -> void:
	# entity.revive()
	entity.movement_provider.enabled = true
