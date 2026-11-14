class_name DotEffect extends ActionEffect

@export var damage: float = 2.0
@export var duration: int = 3

func apply(target: Entity, instigator: Character = null) -> void:
	target.apply_status_effect(DamageStatusEffect.new(target, instigator, damage, duration))