class_name Character extends Entity

@onready var forward_dir: Vector3 = - global_transform.basis.z
var combat_strength = 10

@onready var action_component: ActionComponent = $ActionComponent
@onready var relationship_manager: RelationshipManager = $RelationshipManager
@onready var surroundings_component: SurroundingsComponent = $SurroundingsComponent

func _ready() -> void:
	movement_sm.add_states([JumpState.new(), SprintState.new(), WalkState.new()])
	surroundings_component.setup(relationship_manager, entity_height, get_instance_id())
	super()