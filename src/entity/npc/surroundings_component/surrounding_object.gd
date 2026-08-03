class_name SurroundingObject extends Node

var relationship: Relationship
var combat_strength: int
var timer: Timer

func _init(rel: Relationship, com_str: int = 100) -> void:
    relationship = rel
    combat_strength = com_str

func restart_interaction_timer() -> void:
    if timer:
        timer.start()