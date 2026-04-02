class_name CombatState extends ActivityState

func _init() -> void:
	state_name = "CombatState"

func enter() -> void:
	entity.camera_controller.set_mode(entity.camera_controller.combat_mode)

func exit() -> void:
	entity.camera_controller.set_mode(entity.camera_controller.exploration_mode)