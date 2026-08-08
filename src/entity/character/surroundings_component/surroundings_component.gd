class_name SurroundingsComponent extends Node

var surrounding_objects: Dictionary = {}
var surroundings_range: RangeArea
var relationship_manager: RelationshipManager

func setup(rm: RelationshipManager, entity_height: float, id: int) -> void:
	relationship_manager = rm
	surroundings_range = RangeArea.new(15.0, entity_height / 2, 360.0, id)
	add_sibling(surroundings_range)

func _process(_delta: float) -> void:
	scan_surroundings()

func scan_surroundings() -> void:
	var other_entities = surroundings_range.get_entities_in_range()
	for other_entity in other_entities:
		var id = other_entity.get_instance_id()
		if not surrounding_objects.has(id):
			setup_surrounding_object(id, relationship_manager.get_relationship(other_entity), other_entity.combat_strength)
		else:
			surrounding_objects[id].restart_interaction_timer()

func setup_surrounding_object(id: int, rel: Relationship, com_str: int) -> void:
	var surrounding_object = SurroundingObject.new(rel, com_str)
	add_child(surrounding_object)
	surrounding_object.timer = Timer.new()
	surrounding_object.timer.wait_time = 5.0
	surrounding_object.timer.one_shot = true
	surrounding_object.timer.timeout.connect(_on_interaction_timer_timeout.bind(id))
	surrounding_object.add_child(surrounding_object.timer)
	surrounding_object.timer.start()
	surrounding_objects[id] = surrounding_object

func _on_interaction_timer_timeout(id: int) -> void:
	if surrounding_objects.has(id):
		var surrounding_object = surrounding_objects[id]
		surrounding_objects.erase(id)
		surrounding_object.queue_free()