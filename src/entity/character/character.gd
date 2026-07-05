class_name Character extends Entity

@onready var activity_sm: ActivitySM = $ActivitySM
@onready var action_component: ActionComponent = $ActionComponent

func _ready() -> void:
    movement_sm.add_states([JumpState.new(), SprintState.new(), WalkState.new()])
    activity_sm.setup()
    super()