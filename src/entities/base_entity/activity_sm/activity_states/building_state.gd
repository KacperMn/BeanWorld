class_name BuildingState extends ActivityState

func _init() -> void:
	state_name = "BuildingState"

func enter() -> void:
	entity.camera_controller.set_mode(entity.camera_controller.building_mode)

func exit() -> void:
	entity.camera_controller.set_mode(entity.camera_controller.exploration_mode)