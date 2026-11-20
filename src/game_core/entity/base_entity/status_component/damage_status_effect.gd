class_name DamageStatusEffect extends StatusEffect

var damage_amount: float

func _init(_target: Entity, _instigator: Entity, _damage_amount: float = 10.0, _duration: float = 1.0) -> void:
    damage_amount = _damage_amount
    super(_target, _instigator, _duration)

func apply() -> void:
    if target and target.is_inside_tree():
        instigator.deal_damage(damage_amount, target)