class_name HealEffect extends ActionEffect

@export var amount: float = 10.0

func _init() -> void:
	enters_combat = false

func apply(target: Entity, _instigator: Character = null) -> void:
	target.heal(amount)