class_name ResourceStat extends Stat

var max_value: float:
    get:
        return base_value + bonus_value

var missing_value: float:
    get:
        return max_value - current_value

func _init(base: float) -> void:
    if current_value == null:
        current_value = max_value
    super(base)

func change_value(amount: float) -> void:
    current_value = clampf(current_value + amount, 0, max_value)

func set_value_to_max() -> void:
    current_value = max_value