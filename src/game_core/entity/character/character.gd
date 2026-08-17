class_name Character extends Entity

@onready var facing_direction_node: Node3D = self
@onready var action_component: ActionComponent = $ActionComponent
@onready var awareness_component: AwarenessComponent = $AwarenessComponent

func _ready() -> void:
	awareness_component.setup(self)
	action_component.setup(self, facing_direction_node)
	super()
