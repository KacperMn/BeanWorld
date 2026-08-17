class_name SurroundingsComponent extends Node3D

@onready var surroundings_range: RangeArea = $RangeArea

var surrounding_characters: Dictionary[Character, SurroundingCharacter] = {}
const AWARENESS_GRACE_PERIOD: float = 3.0

var relationship_manager: RelationshipManager
var owner_body: Node3D

func setup(rm: RelationshipManager, _owner: Node3D) -> void:
	relationship_manager = rm
	owner_body = _owner

func _physics_process(delta: float) -> void:
	var expired: Array[Character] = []
	for character in surrounding_characters:
		var entry: SurroundingCharacter = surrounding_characters[character]
		if entry.remaining_time < 0.0:
			continue # still physically in range — no decay
		entry.remaining_time -= delta
		if entry.remaining_time <= 0.0:
			expired.append(character)
	for character in expired:
		surrounding_characters.erase(character)

func _on_range_area_body_entered(body: Node3D) -> void:
	if body == owner_body:
		return
	if body is Character:
		var character: Character = body
		if surrounding_characters.has(character):
			surrounding_characters[character].remaining_time = -1.0
		else:
			print("new guy")
			surrounding_characters[character] = SurroundingCharacter.new(relationship_manager.get_relationship(character), character, -1.0)

func _on_range_area_body_exited(body: Node3D) -> void:
	if body is Character:
		var character: Character = body
		if surrounding_characters.has(character):
			surrounding_characters[character].remaining_time = AWARENESS_GRACE_PERIOD
