class_name Stat extends Resource

@export var base_value: float:
    set(value):
        base_value = value
        current_value += value
        print(current_value)
var bonus_value: float = 0.0:
    set(value):
        bonus_value = value
        current_value += bonus_value
var current_value: float = 0.0

func _init(base: float = 10.0) -> void:
    base_value = base
    current_value = base_value