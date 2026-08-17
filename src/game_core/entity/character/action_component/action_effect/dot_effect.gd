class_name DotEffect extends ActionEffect

@export var amount_per_tick: float = 2.0
@export var tick_count: int = 3
@export var tick_interval: float = 1.0

func apply(target: Entity, instigator: Character) -> void:
	target.apply_dot(amount_per_tick, tick_count, tick_interval)