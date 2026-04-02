class_name Player extends Entity

@onready var camera_controller: CameraController = $CameraController
@onready var action_component: ActionComponent = $ActionComponent
@onready var activity_sm: ActivitySM = $ActivitySM