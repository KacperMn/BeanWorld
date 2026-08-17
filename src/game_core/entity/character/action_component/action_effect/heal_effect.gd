class_name HealEffect extends ActionEffect

@export var amount: float = 10.0

func _init() -> void:
	enters_combat = false

func apply(target: Entity, instigator: Character) -> void:
	target.heal(amount)