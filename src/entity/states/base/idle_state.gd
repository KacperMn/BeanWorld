class_name IdleState extends State


func _init() -> void:
    state_name = "IdleState"

func enter() -> void:
    entity.velocity = Vector3.ZERO

func on_exit() -> void:
    pass

func update(delta: float) -> void:
    pass  # subclasses check for input or AI triggers to transition out