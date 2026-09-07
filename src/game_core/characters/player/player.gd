class_name Player extends Character

@onready var playmode_sm: PlayModeSM = $PlayModeSM
@onready var camera_controller: CameraController = $CameraController
@onready var player_controller: PlayerController = $PlayerController

func _ready() -> void:
	facing_direction_node = camera_controller.camera_arm
	player_controller.setup(facing_direction_node, movement_component) # was: movement_component.movement_sm.camera_arm = ...
	playmode_sm.setup_sm()
	setup_camera_controller()
	super()

func setup_camera_controller() -> void:
	playmode_sm.state_changed.connect(camera_controller._on_playmode_state_changed)