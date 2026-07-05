class_name Player extends CombatCharacter

@onready var camera_controller: CameraController = $CameraController

func _ready() -> void:
	movement_sm.provider = PlayerMovementProvider.new()
	setup_activity_sm()
	super()
	activity_sm.connect("state_changed", Callable(camera_controller, "_on_activity_state_changed"))

func setup_activity_sm() -> void:
	activity_sm.provider = PlayerActivityProvider.new()
	activity_sm.add_states([ExplorationState.new(), BuildingState.new(), PlayerFightingState.new()])
	for state in activity_sm.states:
		if state is ExplorationState:
			activity_sm.current_state = state