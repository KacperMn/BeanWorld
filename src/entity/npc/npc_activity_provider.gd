class_name NPCActivityProvider extends ActivityProvider

var wander_range = RangeQuery.new(10.0)
var entity_detection_range = RangeQuery.new(15.0)

var wander_timer = null
var target_location = null

enum REACTION {
	IGNORE = 0,
	APPROACH = 1,
	FIGHT = 2,
	FLEE = 3,
}

func wander(delta: float) -> void:
	if target_location != null and Vector2(entity.global_position.x - target_location.x, entity.global_position.z - target_location.z).length() < 2.0:
		target_location = null
	elif wander_timer != null:
		wander_timer -= delta
		if wander_timer <= 0.0:
			wander_timer = null
			target_location = wander_range.get_random_location(entity)
	else:
		wander_timer = randf_range(2.0, 5.0)

func entities_in_sight() -> Array[Entity]:
	return entity_detection_range.get_entities_in_range(entity)

func get_reaction(detected_entities: Array[Entity]) -> int:
	if detected_entities.size() > 0:
		# TODO: implement crowd handling
		return REACTION.FIGHT
	elif detected_entities.size() == 1:
		return get_entity_reaction(detected_entities[0])
	else:
		return REACTION.IGNORE

func get_entity_reaction(detected_entity: Entity) -> int:
	var relationship: Relationship = entity.relationship_manager.get_relationship(detected_entity)
	if relationship.fondness < 25.0:
		return get_hostile_reaction(relationship, detected_entity)
	else:
		return REACTION.APPROACH

func get_hostile_reaction(relationship: Relationship, detected_entity: Entity) -> int:
	if relationship.fear > 75.0:
		return REACTION.FLEE;
	else:
		if get_danger(detected_entity) > 50.0:
			return REACTION.FLEE;
		else:
			return REACTION.FIGHT;

func get_danger(_detected_entit: Entity) -> float:
	# analyze entity combat strenth
	return 0.0