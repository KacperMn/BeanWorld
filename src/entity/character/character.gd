class_name Character extends Entity

var combat_strength = 10

@onready var action_component: ActionComponent = $ActionComponent
@onready var surroundings_component: SurroundingsComponent = $SurroundingsComponent
@onready var relationship_manager: RelationshipManager = $RelationshipManager

func _ready() -> void:
	movement_sm.add_states([JumpState.new(), SprintState.new(), WalkState.new()])
	relationship_manager.setup()
	surroundings_component.setup()
	super()

func _physics_process(_delta: float) -> void:
	super(_delta)