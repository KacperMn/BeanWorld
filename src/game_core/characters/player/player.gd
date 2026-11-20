class_name Player extends Character

@onready var playmode_sm: PlayModeSM = $PlayModeSM
@onready var camera_controller: CameraController = $CameraController
@onready var player_controller: PlayerController = $PlayerController

func _ready() -> void:
	player_controller.setup(camera_controller.camera_arm, movement_component, action_component)
	playmode_sm.setup_sm()
	setup_camera_controller()
	super()

func setup_camera_controller() -> void:
	playmode_sm.state_changed.connect(camera_controller._on_playmode_state_changed)