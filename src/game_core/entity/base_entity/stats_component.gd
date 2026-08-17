class_name StatsComponent extends Resource

@export var max_health: float
var current_health: float
@export var movement_speed: float
@export var attack_damage: float
@export var jump_force: float

func _init() -> void:
    if current_health == null:
        current_health = max_health