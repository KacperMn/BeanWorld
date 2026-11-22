class_name Player extends Character

@onready var playmode_sm: PlayModeSM = $PlayModeSM
@onready var camera_controller: CameraController = $CameraController
@onready var player_controller: PlayerController = $PlayerController

func _ready() -> void:
	player_controller.setup(facing_direction_node, movement_component, action_component, playmode_sm)
	playmode_sm.setup_sm()
	setup_camera_controller()
	super()

func setup_camera_controller() -> void:
	camera_controller.global_transform.origin.z = global_transform.origin.z + shape.height * 0.75