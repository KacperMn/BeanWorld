class_name SurroundingCharacter extends RefCounted

var relationship: Relationship
var character: Character
var checked_out: bool
var remaining_time: float

func _init(rel: Relationship, charact: Character, time: float) -> void:
	relationship = rel
	character = charact
	checked_out = false
	remaining_time = time