class_name AwarenessComponent extends Node3D

@onready var relationship_manager: RelationshipManager = $RelationshipManager
@onready var surroundings_component: SurroundingsComponent = $SurroundingsComponent

func setup(owner_node: Character) -> void:
    surroundings_component.setup(relationship_manager, owner_node)
    relationship_manager.setup(owner_node)