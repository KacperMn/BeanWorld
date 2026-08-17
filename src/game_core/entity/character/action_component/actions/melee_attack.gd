class_name MeleeAttack extends Action

@export var effects: Array[ActionEffect] = []

@onready var range_area: RangeArea = $RangeArea

func on_activate() -> void:
	var hits := range_area.get_entities_in_range(-forward_node.global_transform.basis.z)
	for hit in hits:
		print("hit")
		apply_effects(effects, hit)
