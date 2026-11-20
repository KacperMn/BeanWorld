class_name SingleTargetAction extends Action

func on_activate() -> void:
	if _owner.facing_direction_node.facing_ray.is_colliding():
		var hit: Entity = _owner.facing_direction_node.facing_ray.get_collider()
		print("hit")
		apply_effects(effects, hit)
