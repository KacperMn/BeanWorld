class_name MovementProvider extends Provider

var enabled: bool = true

func update(_delta: float) -> void:
    pass

func get_direction(_entity: Entity) -> Vector3:
    return Vector3.ZERO

func wants_jump() -> bool:
    return false

func wants_jump_held() -> bool:
    return false

func wants_sprint() -> bool:
    return false