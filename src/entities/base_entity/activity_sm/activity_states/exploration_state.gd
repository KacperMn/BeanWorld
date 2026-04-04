class_name ExplorationState extends ActivityState

func _init() -> void:
	state_name = "ExplorationState"

func enter() -> void:
	entity.camera_controller.set_mode(entity.camera_controller.exploration_mode)
