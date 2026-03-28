class_name Player extends Entity

@onready var camera_controller: CameraController = $CameraController
@onready var activity_sm: ActivityStateMachine = $ActivityStateMachine
@onready var action_component: ActionComponent = $ActionComponent


func _ready() -> void:
	movement_provider = PlayerMovementProvider.new()
	movement_provider.camera_arm = camera_controller.camera_arm
	movement_sm.setup(self , movement_provider)
	activity_sm.setup(self )
	super ()