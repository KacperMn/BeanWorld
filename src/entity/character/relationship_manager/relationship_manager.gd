class_name RelationshipManager extends Node

var relationships: Dictionary = {}

func unknown_or_uninteracted(other_entity: Entity) -> bool:
    if not has_relationship(other_entity):
        return true
    elif has_relationship(other_entity) && get_relationship(other_entity).interacted_recently:
        return false
    else:
        return false

func get_relationship(other_entity: Entity) -> Relationship:
    if relationships.has(other_entity):
        return relationships[other_entity]
    else:
        return process_first_impression(other_entity)

func process_first_impression(other_entity: Entity) -> Relationship:
    # TODO: implement logic to determine initial fondness and fear based on other_entity's attributes
    var relationship = Relationship.new()
    add_relationship(other_entity, relationship)
    return relationship

func has_relationship(other_entity: Entity) -> bool:
    return relationships.has(other_entity)

func add_relationship(other_entity: Entity, relationship: Relationship) -> void:
    relationships[other_entity] = relationship