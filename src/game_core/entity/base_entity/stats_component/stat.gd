class_name Stat extends Resource

@export var base_value: float = 10.0
var bonus_value: float = 0.0:
    set(value):
        bonus_value = value
        current_value += bonus_value
var current_value: float:
    set(value):
        current_value = value

func _init() -> void:
    current_value = base_value + bonus_value