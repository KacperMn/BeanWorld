class_name Player extends Character

@onready var playmode_sm: PlayModeSM = $PlayModeSM
@onready var camera_controller: CameraController = $CameraController

func _ready() -> void:
	movement_sm.provider = PlayerMovementProvider.new(camera_controller.camera_arm)
	setup_playmode_sm()
	setup_camera_controller()
	super()

func setup_camera_controller() -> void:
	playmode_sm.state_changed.connect(camera_controller._on_playmode_state_changed)

func setup_playmode_sm() -> void:
	playmode_sm.setup()
	combat_sm.entered_combat.connect(playmode_sm._on_combat_entered)
	combat_sm.exited_combat.connect(playmode_sm._on_combat_exited)