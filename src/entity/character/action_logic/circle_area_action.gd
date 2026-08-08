class_name CircleAreaAction extends AreaAction

@export var radius: float = 4.0

func _get_targets() -> Array[Entity]:
	var query := RangeQuery.new()
	query.radius = radius
	query.collision_mask = collision_mask
	return query.get_entities_in_range(_slot.entity, _get_forward())
