class_name DamageEffect extends ActionEffect

@export var amount: float = 10.0

func apply(target: Entity, instigator: Character) -> void:
	target.hurt(amount)
