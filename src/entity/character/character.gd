class_name Character extends Entity

@onready var activity_sm: ActivitySM = $ActivitySM
@onready var action_component: ActionComponent = $ActionComponent
@onready var relationship_manager: RelationshipManager = $RelationshipManager

func _ready() -> void:
    movement_sm.add_states([JumpState.new(), SprintState.new(), WalkState.new()])
    relationship_manager.setup()
    activity_sm.setup()
    super()