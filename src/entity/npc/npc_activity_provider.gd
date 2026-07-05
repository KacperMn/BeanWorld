class_name NPCActivityProvider extends ActivityProvider

var wander_range = RangeQuery.new(10.0)
var entity_detection_range = RangeQuery.new(5.0)

var wander_timer = null
var target_location = null

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
