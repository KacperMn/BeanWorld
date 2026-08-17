class_name Player extends Character

@onready var playmode_sm: PlayModeSM = $PlayModeSM
@onready var camera_controller: CameraController = $CameraController

func _ready() -> void:
	facing_direction_node = camera_controller.camera_arm
	movement_component.provider.camera_arm = facing_direction_node
	playmode_sm.setup_sm()
	setup_camera_controller()
	super()

func setup_camera_controller() -> void:
	playmode_sm.state_changed.connect(camera_controller._on_playmode_state_changed)