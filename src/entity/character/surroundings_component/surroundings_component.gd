class_name SurroundingsComponent extends Node

var entity: Entity
var surrounding_objects: Dictionary = {}

var surroundings_range = RangeQuery.new(15.0)

func setup() -> void:
	entity = get_parent() as Entity

func _process(delta: float) -> void:
	scan_surroundings()

func scan_surroundings() -> void:
	var other_entities = surroundings_range.get_entities_in_range(entity)
	for other_entity in other_entities:
		if other_entity != entity:
			var id = other_entity.get_instance_id()
			if not surrounding_objects.has(id):
				setup_surrounding_object(id, entity.relationship_manager.get_relationship(other_entity), other_entity.combat_strength)
			else:
				surrounding_objects[id].restart_interaction_timer()

func setup_surrounding_object(id: int, rel: Relationship, com_str: int) -> void:
	var surrounding_object = SurroundingObject.new(rel, com_str)
	add_child(surrounding_object)
	surrounding_object.timer = Timer.new()
	surrounding_object.timer.wait_time = 5.0
	surrounding_object.timer.one_shot = true
	surrounding_object.timer.connect("timeout", Callable(self, "_on_interaction_timer_timeout").bind(id))
	surrounding_object.add_child(surrounding_object.timer)
	surrounding_object.timer.start()
	surrounding_objects[id] = surrounding_object

func _on_interaction_timer_timeout(id: int) -> void:
	if surrounding_objects.has(id):
		surrounding_objects.erase(id)
