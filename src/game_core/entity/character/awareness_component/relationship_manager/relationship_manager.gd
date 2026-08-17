class_name RelationshipManager extends Node

var owner_node: Character

var relationships: Dictionary[Character, Relationship] = {}

func setup(_owner_node: Character) -> void:
    owner_node = _owner_node

func get_relationship(other_character: Character) -> Relationship:
    if has_relationship(other_character):
        return get_existing_relationship(other_character)
    else:
        return process_first_impression(other_character)

func process_first_impression(other_character: Character) -> Relationship:
    var relationship = Relationship.new()
    add_relationship(other_character, relationship)
    if other_character.stats_component.attack_damage > owner_node.stats_component.attack_damage:
        relationship.change_fear(-10.0)
    else:
        relationship.change_fear(10.0)
    relationship.change_fondness(50.0)
    return relationship

func get_existing_relationship(other_character: Character) -> Relationship:
    return relationships[other_character]

func has_relationship(other_character: Character) -> bool:
    return relationships.has(other_character)

func add_relationship(other_character: Character, relationship: Relationship) -> void:
    relationships[other_character] = relationship