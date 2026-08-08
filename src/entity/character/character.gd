class_name Character extends Entity

@onready var activity_sm: ActivitySM = $ActivitySM
@onready var action_component: ActionComponent = $ActionComponent
@onready var relationship_manager: RelationshipManager = $RelationshipManager

func _ready() -> void:
	activity_sm.setup()
	movement_sm.add_states([JumpState.new(), SprintState.new(), WalkState.new()])
	relationship_manager.setup()
	super()

func _physics_process(_delta: float) -> void:
	super(_delta)
	activity_sm.set_is_in_combat(is_in_combat)
