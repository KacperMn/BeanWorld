class_name StatsComponent extends Resource

@export var max_health: float
var current_health: float
@export var movement_speed: float
@export var attack_damage: float
@export var jump_force: float

func _init() -> void:
    if current_health == null:
        set_current_health(max_health)

func set_max_health(value: float) -> void:
    max_health = value

func set_current_health(value: float) -> void:
    current_health = value

func set_movement_speed(value: float) -> void:
    movement_speed = value

func set_attack_damage(value: float) -> void:
    attack_damage = value

func set_jump_force(value: float) -> void:
    jump_force = value
