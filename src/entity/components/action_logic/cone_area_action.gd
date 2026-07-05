class_name ConeAreaAction extends AreaAction

@export var radius: float = 4.0
@export var cone_angle: float = 60.0

func _get_targets() -> Array[Entity]:
	var query := RangeQuery.new()
	query.radius = radius
	query.cone_angle = cone_angle
	query.collision_mask = collision_mask
	return query.get_entities_in_range(_slot.entity, _get_forward())
